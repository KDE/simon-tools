#ifndef SIMONTOUCHSTATE_H
#define SIMONTOUCHSTATE_H

#include <QObject>

namespace SimonTouchState {
enum State {
    Main,
    Communication,
    Information,
    Music,
    Images,
    Videos,
    News,
    Orders,
    Requests
};
}


#endif // SIMONTOUCHSTATE_H
