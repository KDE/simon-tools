#ifndef SIMONTOUCHVIEW_H
#define SIMONTOUCHVIEW_H

#include <QObject>
#include "simontouchstate.h"

class SimonTouch;

class SimonTouchView : public QObject
{
    Q_OBJECT

signals:
    void rssFeedReady();
    void rssFeedError();
    void enterState(SimonTouchState::State state);

protected:
    SimonTouch *m_logic;

public:
    SimonTouchView(SimonTouch *logic);

public slots:
    int availableRssFeedsCount();
    QString rssFeedTitle(int id);
    QString rssFeedIcon(int id);
    void fetchRSSFeed(int id);
    void showKeyboard();
    void showCalculator();
    void hideKeyboard();
    void hideCalculator();
};

#endif // SIMONTOUCHVIEW_H
