//
// Aspia Project
// Copyright (C) 2020 Dmitry Chapyshev <dmitry@aspia.ru>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.
//

#include "desktop/screen_capturer_gdi.h"

#include "base/logging.h"
#include "base/win/scoped_select_object.h"
#include "desktop/win/bitmap_info.h"
#include "desktop/win/screen_capture_utils.h"
#include "desktop/desktop_frame_dib.h"
#include "desktop/differ.h"
#include "ipc/shared_memory_factory.h"

#include <dwmapi.h>

namespace desktop {

ScreenCapturerGdi::ScreenCapturerGdi() = default;

ScreenCapturerGdi::~ScreenCapturerGdi() = default;

int ScreenCapturerGdi::screenCount()
{
    return ScreenCaptureUtils::screenCount();
}

bool ScreenCapturerGdi::screenList(ScreenList* screens)
{
    return ScreenCaptureUtils::screenList(screens);
}

bool ScreenCapturerGdi::selectScreen(ScreenId screen_id)
{
    if (!ScreenCaptureUtils::isScreenValid(screen_id, &current_device_key_))
        return false;

    // At next screen capture, the resources are recreated.
    desktop_dc_rect_ = Rect();

    current_screen_id_ = screen_id;
    return true;
}

const Frame* ScreenCapturerGdi::captureFrame(Error* error)
{
    DCHECK(error);

    const Frame* frame = captureImage();
    if (!frame)
    {
        *error = Error::TEMPORARY;
        return nullptr;
    }

    *error = Error::SUCCEEDED;
    return frame;
}

void ScreenCapturerGdi::reset()
{
    // Release GDI resources otherwise SetThreadDesktop will fail.
    desktop_dc_.reset();
    memory_dc_.reset();
}

const Frame* ScreenCapturerGdi::captureImage()
{
    queue_.moveToNextFrame();

    if (!prepareCaptureResources())
        return nullptr;

    Rect screen_rect = ScreenCaptureUtils::screenRect(current_screen_id_, current_device_key_);
    if (screen_rect.isEmpty())
    {
        LOG(LS_WARNING) << "Failed to get screen rect";
        return nullptr;
    }

    if (!queue_.currentFrame() || queue_.currentFrame()->size() != screen_rect.size())
    {
        DCHECK(desktop_dc_);
        DCHECK(memory_dc_);

        std::unique_ptr<Frame> frame = FrameDib::create(
            screen_rect.size(), pixel_format_, sharedMemoryFactory(), memory_dc_);
        if (!frame)
        {
            LOG(LS_WARNING) << "Failed to create frame buffer";
            return nullptr;
        }

        queue_.replaceCurrentFrame(std::move(frame));
    }

    Frame* current = queue_.currentFrame();
    Frame* previous = queue_.previousFrame();

    base::win::ScopedSelectObject select_object(
        memory_dc_, static_cast<FrameDib*>(current)->bitmap());

    BitBlt(memory_dc_,
           0, 0,
           screen_rect.width(), screen_rect.height(),
           *desktop_dc_,
           screen_rect.left(), screen_rect.top(),
           CAPTUREBLT | SRCCOPY);

    current->setTopLeft(screen_rect.topLeft());

    if (!previous || previous->size() != current->size())
    {
        differ_ = std::make_unique<Differ>(screen_rect.size(), pixel_format_);
        current->updatedRegion()->addRect(Rect::makeSize(screen_rect.size()));
    }
    else
    {
        differ_->calcDirtyRegion(previous->frameData(),
                                 current->frameData(),
                                 current->updatedRegion());
    }

    return current;
}

bool ScreenCapturerGdi::prepareCaptureResources()
{
    Rect desktop_rect = ScreenCaptureUtils::fullScreenRect();

    // If the display bounds have changed then recreate GDI resources.
    if (desktop_rect != desktop_dc_rect_)
    {
        desktop_dc_.reset();
        memory_dc_.reset();

        desktop_dc_rect_ = Rect();
    }

    if (!desktop_dc_)
    {
        DCHECK(!memory_dc_);

        // Vote to disable Aero composited desktop effects while capturing.
        // Windows will restore Aero automatically if the process exits.
        // This has no effect under Windows 8 or higher. See crbug.com/124018.
        DwmEnableComposition(DWM_EC_DISABLECOMPOSITION);

        // Create GDI device contexts to capture from the desktop into memory.
        desktop_dc_ = std::make_unique<base::win::ScopedGetDC>(nullptr);
        memory_dc_.reset(CreateCompatibleDC(*desktop_dc_));
        if (!memory_dc_)
        {
            LOG(LS_WARNING) << "CreateCompatibleDC failed";
            return false;
        }

        pixel_format_ = ScreenCaptureUtils::detectPixelFormat();
        desktop_dc_rect_ = desktop_rect;

        // Make sure the frame buffers will be reallocated.
        queue_.reset();
    }

    return true;
}

} // namespace desktop
