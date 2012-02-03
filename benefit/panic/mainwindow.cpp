/*
 *   Copyright (C) 2011 Alexander Breznik <a.breznik@simon-listens.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QDesktopWidget>
#include <QSize>
#include <QTimer>
#include <QProgressBar>

MainWindow::MainWindow(QMainWindow *parent) :
    QMainWindow(parent), ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    // Center the Window
    QDesktopWidget *desktop = QApplication::desktop();
    int screenWidth, width;
    int screenHeight, height;
    int x, y;
    QSize windowSize;
    screenWidth = desktop->width(); // get width of screen
    screenHeight = desktop->height(); // get height of screen
    windowSize = size(); // size of our application window
    width = windowSize.width();
    height = windowSize.height();
    // little computations
    x = (screenWidth - width) / 2;
    y = (screenHeight - height) / 2;
    y -= 50;
    // move window to desired coordinates
    move ( x, y );

    ui_pb1 = qFindChild<QProgressBar*>(this, "pb1");

    QTimer *timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(inc_pb()));
    //connect(timer, SIGNAL(timeout()), this, SLOT(ttest(ui)));

    timer->start(1000);
}

void MainWindow::inc_pb()
{
    ui_pb1->setValue(ui_pb1->value()+1);
    if (ui_pb1->value() == ui_pb1->maximum())
    {
        system("sudo /sbin/reboot");
    }
}

void MainWindow::keyPressEvent(QKeyEvent *e)
{
    if(e->key() == Qt::Key_Q)
    {
        qApp->quit();
    }
}
