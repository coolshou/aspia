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

#ifndef CONSOLE__MRU_ACTION_H
#define CONSOLE__MRU_ACTION_H

#include "base/macros_magic.h"

#include <QAction>

namespace console {

class MruAction : public QAction
{
    Q_OBJECT

public:
    MruAction(const QString& file, QObject* parent = nullptr);

    QString filePath() const { return file_path_; }

private:
    QString file_path_;

    DISALLOW_COPY_AND_ASSIGN(MruAction);
};

} // namespace console

#endif // CONSOLE__MRU_ACTION_H
