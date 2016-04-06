#include <iostream>
#include <functional>
#include <vector>
#include <map>
#include <set>
#include <type_traits>
#include <utility>
 
/////////////////////////////////////////
//
// Listener and Notifier classes:
//
/////////////////////////////////////////
 
class Listener;
class NotifierBase {
public:
        virtual void disconnect(Listener*) {}
};
 
class Listener {
public:
        virtual ~Listener()
        {
                for (auto signal: signals) {
                        signal->disconnect(this);
                }
        }
 
        void registerNotifier(NotifierBase* signal)
        {
                signals.insert(signal);
        }
 
        void unregisterNotifier(NotifierBase* signal)
        {
                signals.erase(signal);
        }
 
        std::set<NotifierBase*> signals;
};
 
template<typename T, typename... Args>
class Notifier : public NotifierBase {
public:
        Notifier() {}
        ~Notifier()
        {
                for (auto slot: slots) {
                        slot.first->unregisterNotifier(this);
                }
        }
 
        void connect(Listener* object, std::function<void(T, Args...)> slot)
        {
                slots[object] = slot;
                object->registerNotifier(this);
        }
 
        void disconnect(Listener* object)
        {
                slots.erase(object);
        }
 
        void notify(T t, Args...args)
        {
                for (auto slot: slots) {
                        slot.second(t, args...);
                }
        }
 
        std::map<Listener*, std::function<void(T, Args...)>> slots;
};
 
/////////////////////////////////////////
//
// Code which I don't understand but does something clever and produces a compile warning:
//
/////////////////////////////////////////
 /*
template<unsigned... Is> struct seq{};
template<unsigned I, unsigned... Is>
struct gen_seq : gen_seq<I-1, I-1, Is...>{};
template<unsigned... Is>
struct gen_seq<0, Is...> : seq<Is...>{};
 
template<unsigned I> struct placeholder{};
 
namespace std{
template<unsigned I>
struct is_placeholder< ::placeholder<I> > : integral_constant<int, I>{};
} // std::
 
namespace aux{
template<unsigned... Is, class F, class... Ts>
auto easy_bind(seq<Is...>, F&& f, Ts&&... vs) -> decltype(std::bind(std::forward<F>(f), std::forward<Ts>(vs)..., ::placeholder<1 + Is>()...)) {
    return std::bind(std::forward<F>(f), std::forward<Ts>(vs)..., ::placeholder<1 + Is>()...);
}
} // aux::
 
template<class R, class C, class... FArgs, class... Args>
auto mem_bind(R (C::*ptmf)(FArgs...), Args&&... vs) -> decltype(aux::easy_bind(gen_seq<(sizeof...(FArgs) + 1) - sizeof...(Args)>(), ptmf, std::forward<Args>(vs)...)) {
    // the +1s for 'this' argument
    static_assert(sizeof...(Args) <= sizeof...(FArgs) + 1, "too many arguments to mem_bind");
    return aux::easy_bind(gen_seq<(sizeof...(FArgs) + 1) - sizeof...(Args)>(), ptmf, std::forward<Args>(vs)...);
}
 
template<class T, class C, class... Args>
auto mem_bind(T C::*ptmd, Args&&... vs) -> decltype(aux::easy_bind(gen_seq<1 - sizeof...(Args)>(), ptmd, std::forward<Args>(vs)...)) {
    // just 'this' argument
    static_assert(sizeof...(Args) <= 1, "too many arguments to mem_bind");
    return aux::easy_bind(gen_seq<1 - sizeof...(Args)>(), ptmd, std::forward<Args>(vs)...);
}
 */
 
 
/////////////////////////////////////////
//
//  Example:
//
/////////////////////////////////////////
 
class MyObject : public Listener {
public:
        void onMouseMoved(int x, int y)
        {
                std::cout << __PRETTY_FUNCTION__ << std::endl;
                std::cout << "Mouse moved: " << x << "," << y << std::endl;
        }
};
 
class MyObject2 : public Listener {
public:
        void mouseMoved(int x, int y)
        {
                std::cout << __PRETTY_FUNCTION__ << std::endl;
                std::cout << "Mouse moved: " << x << "," << y << std::endl;
        }
};
 
class Button {
public:
        Notifier<int, int> mouseMove; // arguments: (int x, int y)
 
        void emulateMouseMove(int x, int y)
        {
                mouseMove.notify(x, y);
        }
};
 
 
#define CONN(O, M) &O, mem_bind(&decltype(O)::M, O)
#define _connect(SRC, SIG, TAR, SLO) SRC.SIG.connect(&TAR, mem_bind(&decltype(TAR)::SLO, TAR))
 
int main()
{
        Button btn;
 
        MyObject object;
        //btn.mouseMove.connect(&object, std::bind(&MyObject::onMouseMoved, std::ref(object), std::placeholders::_1, std::placeholders::_2 )); // 'Vanilla' interface
        btn.mouseMove.connect(&object, std::bind(&decltype(object)::onMouseMoved, std::ref(object), std::placeholders::_1, std::placeholders::_2 )); // Use decltype
        //btn.mouseMove.connect(&object, mem_bind(&decltype(object)::onMouseMoved, object)); // Use clever mem_bind construct
        //btn.mouseMove.connect(CONN(object, onMouseMoved)); // Use convenience macro
 
        //_connect(btn, mouseMove, object, onMouseMoved);
 
        //MyObject2 object2;
        //btn.mouseMove.connect(CONN(object2, mouseMoved));
 
        // Now trigger the notification
        btn.emulateMouseMove(10,10);
}