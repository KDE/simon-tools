#include "simontouchview.h"
#include "simontouch.h"
#include <QStringList>

SimonTouchView::SimonTouchView(SimonTouch *logic) :
    m_logic(logic)
{
}

int SimonTouchView::availableRssFeedsCount()
{
    return m_logic->rssFeedNames().count();
}

QString SimonTouchView::rssFeedTitle(int id)
{
    if (id >= availableRssFeedsCount())
        return QString();

    return m_logic->rssFeedNames()[id];
}

QString SimonTouchView::rssFeedIcon(int id)
{
    if (id >= availableRssFeedsCount())
        return QString();

    return m_logic->rssFeedIcons()[id];
}

void SimonTouchView::fetchRSSFeed(int id)
{
    m_logic->fetchRssFeed(id);
}
