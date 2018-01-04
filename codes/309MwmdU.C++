#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <math.h>
#include <unordered_map>
#include <iterator>
#include <climits>

//TODO
/*

* DONE : FIX relevancy fail for distance from closest on some cases 
* DONE : FIX buster ignoring Ghost because of ID confict (will be fixed if UID in place)
* DONE : Handle case when ennemy carry a ghost
* DONE : Finiish refacto code
* DONE : Ennemy carrying a ghost is a number one priority
* DONE : Buster carrying a ghost must go on the edge
* > Buster carrying a ghost must not step in ennemy proximity
* DONE : Buster zapping an ennemy carrying a ghost must go capture this ghost
* If buster is Idle go for 

*/

class Vec2
{
    private:
    
    int64_t x;
    int64_t y;
    
    public:
    
    Vec2(int64_t x, int64_t y)
    {
        this->x = x;
        this->y = y;
    }
    Vec2(const Vec2 &rhs)
    {
        this->x = rhs.X();
        this->y = rhs.Y();
    }
    void operator=(const Vec2 &rhs)
    {
        this->x = rhs.X();
        this->y = rhs.Y();
    }
    Vec2 operator-(const Vec2 &rhs) const
    {
        return Vec2(x - rhs.X(), y - rhs.Y());
    }
    Vec2 operator*(const size_t& mult) const
    {
        return Vec2(x * mult, y * mult);
    }
    std::string toStr() const
    {
        return std::to_string(x) + " " + std::to_string(y);
    }
    void setPos(int x, int y)
    {
        this->x = x;
        this->y = y;
    }
    int64_t length() const
    {
        return sqrt(x*x + y*y);
    }
    int64_t lengthSqr() const
    {
        return x*x + y*y;
    }
    Vec2 normalize() const
    {
        const float lgth = this->length();
        return Vec2(x/lgth, y/lgth);
    }
    int X() const { return x; }
    int Y() const { return y; }
};

//Game parameters
namespace PARAMS
{
    namespace GAME
    {
        const unsigned int maxTurnCount         {250};
        size_t TeamID;
        size_t BustersPerPlayer;
        size_t GhostCount;
        size_t curTS;
    }
    namespace MAP
    {
        const Vec2 topLeft                      (0,0);
        const Vec2 bottomRight                  (16000, 9000);
        Vec2 TeamBasePos                        (0,0);
        Vec2 EnnemyBasePos                      (0,0);
    }
    namespace BUSTER
    {
        const unsigned int FogStartDistance     {2200};
        const unsigned int MoveUnit             {800};
        const unsigned int MoveUnitSqr          {MoveUnit * MoveUnit};
        const unsigned int BustRangeIN          {900};
        const unsigned int BustRangeOUT         {1760};
        const unsigned int BustMaxCarryCount    {1};
        const unsigned int ReleaseMaxDistance   {1600};
        const unsigned int ReleaseMaxDistanceSqr{ReleaseMaxDistance * ReleaseMaxDistance};
        const unsigned int StunDistance         {1760};
        const unsigned int StunDistanceSqr      {StunDistance * StunDistance};
        const unsigned int StunCD               {20};
    }
    namespace GHOST 
    {
        const unsigned int MoveUnit             {400};
    }
}

enum class BusterActiveState
{
    IDLE,
    CARRYING,
    STUNNED,
    TRAPPING,
    UNKONWN = 999
};

class Entity{
    public: 
    Entity(size_t ID, int teamID) 
    : playerControlled(teamID == PARAMS::GAME::TeamID), 
    m_ID(ID), 
    m_TeamID(teamID), 
    m_state(BusterActiveState::IDLE),
    m_pos(0,0),
    m_lastSeen(0),
    m_value(0),
    tagged(false),
    tagCounter(0)
    {
    }
    //ctor used when Entity is valid
    Entity(size_t ID, int teamID, Vec2 pos, size_t state, int value)
    : playerControlled(teamID == PARAMS::GAME::TeamID),
    m_ID(ID), m_TeamID(teamID), m_pos(pos), m_lastSeen(0), tagged(false), tagCounter(0)
    {
        m_state = getState(state);
        m_value = value;
    }
    
    Entity(size_t ID, int teamID, Vec2 pos, BusterActiveState state, int value)
    : playerControlled(teamID == PARAMS::GAME::TeamID),
    m_ID(ID), m_TeamID(teamID), m_pos(pos), m_lastSeen(0), tagged(false), tagCounter(0), m_value(value)
    {
    }
    
    bool operator==(const Entity &rhs) const { return m_ID == rhs.ID(); }
    
    //entity ID
    size_t ID() const               { return m_ID; }
    int TeamID() const              { return m_TeamID; }
    int Value() const               { return m_value; }
    Vec2 Pos() const                { return m_pos; }
    void setPos(Vec2 pos)           { m_pos = pos; }
    BusterActiveState State() const { return m_state; }
    size_t TimeStamp() const        { return m_lastSeen; }
    
    void Tag()                      { ++tagCounter; tagged = true;}
    void UnTag()                    { --tagCounter; tagged = (tagCounter > 0) ? true : false; }
    bool Tagged() const             { return tagged; }
    size_t TagCounter() const       { return tagCounter; }
    
    //update inner state from passe din data
    void update(Vec2 lastSeenPos, size_t timestamp, BusterActiveState state, int value)
    {
        m_state = state;
        m_lastSeen = timestamp;
        m_pos = lastSeenPos;
        m_value = value;
    }
    
    std::string toStr() const
    {
        return (m_TeamID >= 0) ? std::string("Buster") : std::string("Ghost");
    }
    
    bool isPlayerControlled() const { return playerControlled; }
    
    private: 
    //entity ID
    const size_t m_ID;
    // -1 : Ghost
    const int m_TeamID;
    
    BusterActiveState getState(size_t state) const
    {
        switch(state)
        {
            case 0: return BusterActiveState::IDLE;
            case 1: return BusterActiveState::CARRYING;
            case 2: return BusterActiveState::STUNNED;
            case 3: return BusterActiveState::TRAPPING;
        }
        return BusterActiveState::UNKONWN;
    }
    
    //current Entity position
    Vec2 m_pos;
    //Only busters use this
    BusterActiveState m_state;
    //Timestamp lastSeen
    size_t m_lastSeen;
    //value of entity
    int m_value;
    //
    bool tagged;
    // amount of friendly buster tagged in
    size_t tagCounter;
    
    //true if same team as player
    const bool playerControlled;
};

class Ghost : public Entity
{
    public:
    Ghost(size_t ID, int teamID);
    Ghost(size_t ID, int teamID, Vec2 pos, BusterActiveState state, int value);
    
    void setStamina(size_t stamina_t)   { stamina = stamina_t; }
    size_t Stamina() const              { return stamina; }
    
    private:
    size_t stamina;
};

Ghost::Ghost(size_t ID, int teamID)
: Entity(ID, teamID), stamina(0)
{
}

Ghost::Ghost(size_t ID, int teamID, Vec2 pos, BusterActiveState state, int value)
: Entity(ID, teamID, pos, state, value), stamina(0)
{
}

class Ennemy : public Entity
{
    public:
    Ennemy(size_t ID, int teamID);
    Ennemy(size_t ID, int teamID, Vec2 pos, BusterActiveState state, int value);
    
    void setLastStun(size_t timestamp)  { m_lastStun = timestamp; }
    size_t LastStun() const             { return m_lastStun; }
    
    private:
    size_t m_lastStun;
};

Ennemy::Ennemy(size_t ID, int teamID)
: Entity(ID, teamID)
{
}

Ennemy::Ennemy(size_t ID, int teamID, Vec2 pos, BusterActiveState state, int value)
: Entity(ID, teamID, pos, state, value)
{
}

class BusterAIMaster;
class BusterAIState;

class Buster : public Entity
{
    private:
    BusterAIState* m_state;
    Ghost* m_target;
    Ennemy* m_badBuster;
    Vec2 m_destination;
    bool targetIsContested;
    bool stunnedABadGuy;
    bool usedRadar;
    int stunCD;
    
    public:
    Buster(size_t ID, int teamID);
    Buster(size_t ID, int teamID, Vec2 pos, BusterActiveState state, int value);
    
    void ProcessCDs();
    void handle();
    void setState(BusterAIState* state);
    BusterAIState* AIState()                        { return m_state; }
    
    void setTarget(Ghost* ghost)                    { if(m_target != nullptr) m_target->UnTag(); m_target = ghost; m_target->Tag();}
    void setBadBuster(Ennemy* ennemy)               { if(m_badBuster != nullptr) m_badBuster->UnTag(); m_badBuster = ennemy; m_badBuster->Tag();}
    bool IsTargetContested() const                  { return targetIsContested; }
    bool HasStunnedABadGuy() const                  { return stunnedABadGuy; }
    bool HasUsedradar() const                       { return usedRadar; }
    void setTargetContested(bool contested)         { targetIsContested = contested; }
    void setStunnedABadGuy(bool stunned)            { stunnedABadGuy = stunned; }
    void setUsedRadar(bool state)                   { usedRadar = state; }
    void invalidateTarget()                         { if(m_target != nullptr) m_target->UnTag(); m_target = nullptr; }
    void stunEnnemy(size_t timestamp)               { stunCD = PARAMS::BUSTER::StunCD; m_badBuster->setLastStun(timestamp); stunnedABadGuy = true;}
    bool canStun() const                            { return stunCD == 0; }
    size_t getStunCD() const                        { return stunCD; }
    const Ghost* Target() const                     { return m_target; }
    Ghost* fTarget()                                { return m_target; }
    const Ennemy* BadBuster() const                 { return m_badBuster; }
    const Vec2 Destination() const                  { return m_destination; }
    void setDestination(Vec2 destination)           { m_destination = destination;}
    
    void ResetInnerAIState()
    {
        m_state = nullptr;
        
        if(m_target != nullptr) m_target->UnTag();
        if(m_badBuster != nullptr) m_badBuster->UnTag();
        
        m_target = nullptr;
        m_badBuster = nullptr;
    }
};

class BusterAIState
{
    public:
    virtual void handle() = 0;
    virtual bool isDirty() = 0;
    
    protected:
    BusterAIState(bool dirty_t = false) : dirty(dirty_t) {}
    bool dirty;
};

class BAI_MoveTo : public BusterAIState
{
    private:
    
    Buster* m_context;
    BusterAIMaster* m_master;
        
    public:
    
    BAI_MoveTo(Buster* context, BusterAIMaster* master) : BusterAIState(), m_context (context), m_master(master) {}
    void handle();
    
    bool isDirty()
    {
        return dirty;
    }
};

class BAI_UseRadar : public BusterAIState
{
    private:
    
    Buster* m_context;
    BusterAIMaster* m_master;
        
    public:
    
    BAI_UseRadar(Buster* context, BusterAIMaster* master) : BusterAIState(), m_context (context), m_master(master) {}
    void handle();
    
    bool isDirty()
    {
        return dirty;
    }
};

class BAI_Stun : public BusterAIState
{
    private:
    
    Buster* m_context;
    BusterAIMaster* m_master;
        
    public:
    
    BAI_Stun(Buster* context, BusterAIMaster* master) : BusterAIState(), m_context (context), m_master(master) {}
    void handle();
    
    bool isDirty()
    {
        return dirty;
    }
};

class BAI_ReleaseGhost : public BusterAIState
{
    private:
    
    Buster* m_context;
    BusterAIMaster* m_master;
        
    public:
    
    BAI_ReleaseGhost(Buster* context, BusterAIMaster* master) : BusterAIState(), m_context (context), m_master(master) {}
    void handle();
    
    bool isDirty()
    {
        return dirty;
    }
};

class BAI_CaptureGhost : public BusterAIState
{
    private:
    
    Buster* m_context;
    BusterAIMaster* m_master;
        
    public:
    
    BAI_CaptureGhost(Buster* context, BusterAIMaster* master) : BusterAIState(), m_context (context), m_master(master) {}
    void handle();
    
    bool isDirty();
};

class BAI_InterceptEnnemy : public BusterAIState
{
    private:
    
    Buster* m_context;
    BusterAIMaster* m_master;
        
    public:
    
    BAI_InterceptEnnemy(Buster* context, BusterAIMaster* master) : BusterAIState(), m_context (context), m_master(master) {}
    void handle();
    
    bool isDirty()
    {
        return dirty;
    }
};

Buster::Buster(size_t ID, int teamID)
: Entity(ID, teamID), m_destination(0, 0), targetIsContested(false), stunCD(0), stunnedABadGuy(false), usedRadar(false)
{
    m_state = nullptr;
    m_target = nullptr;
    m_badBuster = nullptr;
}

Buster::Buster(size_t ID, int teamID, Vec2 pos, BusterActiveState state, int value)
: Entity(ID, teamID, pos, state, value), m_destination(pos), targetIsContested(false), stunCD(0), stunnedABadGuy(false), usedRadar(false)
{
    m_state = nullptr;
    m_target = nullptr;
    m_badBuster = nullptr;
}

void Buster::ProcessCDs()
{
    //update CD
    if(stunCD > 0) --stunCD;
}

void Buster::handle() 
{ 
    //play state
    m_state->handle();
}

void Buster::setState(BusterAIState* state)
{
    m_state = state;
    std::cerr << ID() << " enters a new state" << std::endl;
    if(m_state->isDirty())
        std::cerr << ID() << " enters a dirty State" << std::endl;
}

using Entities = std::vector<size_t>;

using GhostsMap = std::unordered_map<size_t ,Ghost*>;
using EnnemiesMap = std::unordered_map<size_t ,Ennemy*>;
using BustersMap = std::unordered_map<size_t ,Buster*>;

using GhostEntry = std::pair<size_t ,Ghost*>;
using EnnemyEntry = std::pair<size_t ,Ennemy*>;
using BusterEntry = std::pair<size_t ,Buster*>;

class BusterAIMaster
{
    public:
    BusterAIMaster(size_t bustersCount, size_t ghostsCount) 
    : BustersCount(bustersCount),GhostsCount(ghostsCount), curTimeStamp(0), curScoutIndex(0), curScore(0)
    {
        //initialize scoutPositions
        scoutPositions.push_back(Vec2(8000, 4500));
        
        scoutPositions.push_back(Vec2(15000, 1000));
        scoutPositions.push_back(Vec2(16000, 4000));
        scoutPositions.push_back(Vec2(14000, 7000));
        scoutPositions.push_back(Vec2(10000, 8000));
        
        scoutPositions.push_back(Vec2(1000, 8000));
        scoutPositions.push_back(Vec2(6000, 0));
        scoutPositions.push_back(Vec2(2000, 2000));
        scoutPositions.push_back(Vec2(0, 4000));
        
        scoutPositions.push_back(Vec2(12000, 1000));
        scoutPositions.push_back(Vec2(6000, 8000));
    }
    
    void Update(const Entity& entity, size_t state)
    {
        // indexing Entity Id = 2 TeamId = -1 as 20. (21 - 1) 
        // indexing Entity Id = 0 TeamId = 1 as 2. (1 + 1) 
        /*
        if(entity.TeamID() != PARAMS::GAME::TeamID)
            std::cerr << "Seeing : " << entity.ID() << std::endl;
        */
            
        size_t uid = (1 + entity.ID() * 10 + entity.TeamID()); 
        Entities::iterator got = std::find (entities.begin(), entities.end(), uid);
        
        if ( got == entities.end() )
        {
            //add the entity to the appropriate list
            if(entity.TeamID() == -1)
            {
                m_ghosts.insert(GhostEntry(entity.ID(), new Ghost(entity.ID(), entity.TeamID(), entity.Pos(), entity.State(), entity.Value())));
                 m_ghosts[entity.ID()]->setStamina(state);
            }
            else
            {
                if(entity.TeamID() == PARAMS::GAME::TeamID)
                {
                    bustersIDs.push_back(entity.ID());
                    m_busters.insert(BusterEntry(entity.ID(), new Buster(entity.ID(), entity.TeamID(), entity.Pos(), entity.State(), entity.Value())));
                }
                else
                {
                    m_ennemies.insert(EnnemyEntry(entity.ID(), new Ennemy(entity.ID(), entity.TeamID(), entity.Pos(), entity.State(), entity.Value())));
                }
            }
            //add to the seen vector
            entities.push_back(uid);
        }
        else
        {
            //Update the found entity
            if(entity.TeamID() == -1)
            {
                m_ghosts[entity.ID()]->update(entity.Pos(), curTimeStamp, entity.State(), entity.Value());
                m_ghosts[entity.ID()]->setStamina(state);
            }
            else
            {
                if(entity.TeamID() == PARAMS::GAME::TeamID)
                {
                    
                    if(m_busters[entity.ID()]->State() == BusterActiveState::STUNNED && entity.State() != BusterActiveState::STUNNED)
                    {
                        std::cerr << entity.ID() << " leaving stun state " << std::endl;
                        m_busters[entity.ID()]->ResetInnerAIState();
                        m_busters[entity.ID()]->update(entity.Pos(), curTimeStamp, entity.State(), entity.Value());
                        goScouting(m_busters[entity.ID()]);
                    }
                    else
                    {
                        m_busters[entity.ID()]->update(entity.Pos(), curTimeStamp, entity.State(), entity.Value());
                    }
                }
                else
                {
                    m_ennemies[entity.ID()]->update(entity.Pos(), curTimeStamp, entity.State(), entity.Value());
                }
            }
        }
    }
    
    void HandleBusters()
    {
        std::vector<Ghost*> curMVPs;
        for (auto it : m_ghosts)
        {
            Ghost* e = (it.second);
            //must not be a player
            if(!isSomeoneCarryingGhost(e))
            {
                if(curTimeStamp - e->TimeStamp() == 0)
                {
                    if(curTimeStamp < 25)
                    {
                        if(e->Stamina() == 3)
                            curMVPs.push_back(e);
                    }
                    else
                    {
                        if(curTimeStamp < 60)
                        {
                            if(e->Stamina() <= 16)
                                curMVPs.push_back(e);
                        }
                        else
                        {
                            curMVPs.push_back(e);
                        }
                    }
                }
            }
        }
        
        std::cerr << "Found " << curMVPs.size() << " relevant Ghost(s)" << std::endl;
        
        for(size_t id : bustersIDs)
        {
            Buster* buster = m_busters[id];
            //process Cooldowns
            buster->ProcessCDs();
            //make a decision
            makeDecision(buster, curMVPs);
        }
        
        for(size_t id : bustersIDs)
        {
            Buster* buster = m_busters[id];
            if(buster->State() != BusterActiveState::STUNNED)
            {
                buster->handle();
            }
            else
            {
                std::cerr << buster->ID() << " is stunned :(" << std::endl;
                std::cout << "MOVE " << buster->Pos().toStr() << std::endl;
            }
        }
    }
    
    // true if already Tagged
    Ghost* getClosestEntity(Buster* buster, std::vector<Ghost*>& curMVPs, bool& isTargetTagged, bool excludeTagged = false)
    {
        Ghost* closest = nullptr;
        size_t distSqr = ULONG_MAX;
        for(Ghost* e : curMVPs)
        {
            if(e->Stamina() <= 3)
            {
                if(!excludeTagged || (!e->Tagged() && excludeTagged))
                {
                    isTargetTagged = e->Tagged();
                    closest = e;
                    break;
                }
            }
            size_t distSqr_t = Vec2(e->Pos() - buster->Pos()).lengthSqr();
            if(distSqr_t < distSqr)
            {
                if(excludeTagged)
                {
                    if(!e->Tagged())
                    {
                        isTargetTagged = false;
                        distSqr = distSqr_t;
                        closest = e;
                    }
                }
                else
                {
                    isTargetTagged = e->Tagged();
                    distSqr = distSqr_t;
                    closest = e;
                }
            }
        }
        return closest;
    }
    
    void goScouting(Buster* buster)
    {
        if(curScore < (GhostsCount / 2) - 1) 
        {
            scout(buster);
        }
        else
        {
            bool newState = false;
            for(size_t id : bustersIDs)
            {
                Buster* buster_t = m_busters[id];
                if(buster_t->ID() != buster->ID())
                {
                    if(buster_t->State() == BusterActiveState::CARRYING)
                    {
                        buster->setDestination(buster_t->Pos());
                        buster->setState(new BAI_MoveTo(buster, this));
                        newState = true;
                        break;
                    }
                    else
                    {
                        if(buster_t->State() == BusterActiveState::TRAPPING)
                        {
                            buster->setTarget(buster_t->fTarget());
                            buster->setState(new BAI_CaptureGhost(buster, this));
                            newState = true;
                        }
                    }
                }
            }
            if(!newState)
            {
                for(auto ennemy : m_ennemies)
                {
                    if(ennemy.second->State() == BusterActiveState::CARRYING)
                    {
                        Vec2 dest = (PARAMS::GAME::TeamID == 0) ? Vec2(1450, 7500) : Vec2(1500, 1500);
                        buster->setDestination(dest);
                        buster->setState(new BAI_MoveTo(buster, this));
                        newState = true;
                        break;
                    }
                    else
                    {
                        if(ennemy.second->State() == BusterActiveState::TRAPPING && curTimeStamp - ennemy.second->TimeStamp() == 0)
                        {
                            buster->setDestination(ennemy.second->Pos());
                            buster->setState(new BAI_MoveTo(buster, this));
                            newState = true;
                        }
                    }
                }
                if(!newState)
                {
                    scout(buster);
                }
            }
        }
    }
    
    void scout(Buster* buster)
    {
        std::cerr << "Scouting" << std::endl;
        ++curScoutIndex;
        if(curScoutIndex == scoutPositions.size()) curScoutIndex = 0;
        buster->setDestination(scoutPositions[curScoutIndex]);
        buster->setState(new BAI_MoveTo(buster, this));
    }
    
    void CaptureGhost(Buster* buster, Ghost* ghost)
    {
        std::cerr << "Capturing" << std::endl;
        if(ghost != nullptr)
        {
            buster->setTarget(ghost);
            buster->setState(new BAI_CaptureGhost(buster, this));
        }
    }
    
    void MoveTo(Buster* buster,const Vec2& destination)
    {
        std::cerr << "Moving" << std::endl;
        buster->setDestination(destination);
        buster->setState(new BAI_MoveTo(buster, this));
    }
    
    void Intercept(Buster* buster, Ennemy* ennemy)
    {
        std::cerr << "Intercepting" << std::endl;
        if(ennemy != nullptr)
        {
            buster->setBadBuster(ennemy);
            buster->setState(new BAI_InterceptEnnemy(buster, this));
        }
    }
    
    void Stun(Buster* buster, Ennemy* ennemy)
    {
        std::cerr << "Stunning" << std::endl;
        if(ennemy != nullptr && buster->BadBuster() == nullptr)
        {
            buster->setBadBuster(ennemy);
            buster->setState(new BAI_InterceptEnnemy(buster, this));
        }
    }
    
    void LookForValuableTarget(Buster* buster, std::vector<Ghost*>& curMVPs, Ghost* closest)
    {
        for(size_t id : bustersIDs)
        {
            Buster* buster_t = m_busters[id];
            if(buster_t->Target() != nullptr)
            {
                if(*(buster_t->Target()) == *closest)
                {
                    auto distTempToTarget = Vec2(buster_t->Pos() - closest->Pos()).lengthSqr();
                    auto distBusterToTarget = Vec2(buster->Pos() - closest->Pos()).lengthSqr();
                    if( ( distTempToTarget > distBusterToTarget) 
                        && (buster_t->State() != BusterActiveState::CARRYING && buster_t->State() != BusterActiveState::TRAPPING ) )
                    {
                        //target is already tagged but Buster is closer to target
                        CaptureGhost(buster, m_ghosts[closest->ID()]) ;
                        
                        std::cerr << buster_t->ID() << " st : " << (int)buster_t->State() << " is more far from " << closest->ID() << " than " << buster->ID() << std::endl;
                        
                        buster_t->setTargetContested(true);
                        makeDecision(buster_t, curMVPs, buster);
                        break;
                    }
                }
            }
            
        }
        if(buster->Target() == nullptr)
        {
            //The other Buster is closer
            bool isTargetTagged = false;
            closest = getClosestEntity(buster, curMVPs, isTargetTagged, true);
            if(closest != nullptr)
            {
                //target is already tagged but Buster is closer to target
                CaptureGhost(buster, m_ghosts[closest->ID()]) ;
            }
        }
    }
    
    bool isSomeoneCarryingGhost(const Ghost* ghost)
    {
        size_t ghostID = ghost->ID();
        bool isCarrying = false;
        for(size_t id : bustersIDs)
        {
            Buster* buster = m_busters[id];
            if(buster->Value() == ghostID && buster->State() == BusterActiveState::CARRYING)
            {
                isCarrying = true;
                break;
            }
        }
        if(!isCarrying)
        {
            for(auto ennemy : m_ennemies)
            {
                if(ennemy.second->Value() == ghostID && ennemy.second->State() == BusterActiveState::CARRYING)
                {
                    isCarrying = true;
                    break;
                }
            }
        }
        
        return isCarrying;
    }
    
    bool isABusterAttacking(Buster* buster, Ennemy* e)
    {
        bool attacking = false;
        for(size_t id : bustersIDs)
        {
            Buster* buster_t = m_busters[id];
            if(buster_t->BadBuster() == e && buster != buster_t)
            {
                attacking = true;
                break;
            }
        }
        return attacking;
    }
    
    Ennemy* closestVisibleEnnemy(const Vec2& b_pos, Ennemy* excludedEnnemy = nullptr)
    {
        Ennemy* closest = nullptr;
        //make sure it's relevant (timestamp diff = 0 && not already stunned)
        for(auto ennemy : m_ennemies)
        {
            Ennemy* e = ennemy.second;
            if(curTimeStamp - e->TimeStamp() == 0)
            {
                if(e->State() != BusterActiveState::STUNNED)
                {
                    if(Vec2(b_pos - e->Pos()).lengthSqr() < PARAMS::BUSTER::StunDistanceSqr)
                    {
                        if(e != excludedEnnemy)
                        {
                            closest = e;
                            //if target is CARRYING ghost it's a priority target
                            if(e->State() == BusterActiveState::CARRYING)
                            {
                                break;
                            }
                        }
                    }
                }
            }
        }
        
        return closest;
    }
    
    //return the best target from our current position
    Ennemy* bestTarget(const Vec2& b_pos)
    {
        Ennemy* bestT = nullptr;
        //make sure it's relevant (timestamp diff = 0 && not already stunned)
        for(auto ennemy : m_ennemies)
        {
            Ennemy* e = ennemy.second;
            if(curTimeStamp - e->TimeStamp() == 0)
            {
                if(e->State() == BusterActiveState::CARRYING)
                {
                    if(Vec2(b_pos - PARAMS::MAP::EnnemyBasePos).lengthSqr() + (PARAMS::BUSTER::StunDistance) < Vec2(e->Pos() - PARAMS::MAP::EnnemyBasePos).lengthSqr())
                    {
                        bestT = e;
                        break;
                    }
                }
            }
        }
        
        return bestT;
    }
    
    void makeDecision(Buster* buster, std::vector<Ghost*>& curMVPs, Buster* instigator = nullptr)
    {
        std::cerr << buster->ID() << " is thinking ..." << std::endl;
        if(buster->AIState() != nullptr)
        {
            if(buster->AIState()->isDirty())
            {
                if(buster->HasStunnedABadGuy())
                {
                    std::cerr << buster->ID() << " Killed a guy now go for the loot" << std::endl;
                    Vec2 gotoPos = buster->BadBuster()->Pos();
                    buster->ResetInnerAIState();
                    buster->setStunnedABadGuy(false);
                    MoveTo(buster, gotoPos);
                }
                else
                {
                    buster->ResetInnerAIState();
                }
            }
        }
        
        if(buster->State() != BusterActiveState::STUNNED)
        {
            if(buster->Target() != nullptr && buster->State() != BusterActiveState::CARRYING)
            {
                if(isSomeoneCarryingGhost(buster->Target()) || curTimeStamp - buster->Target()->TimeStamp() > 10 || Vec2(buster->Target()->Pos() - buster->Pos()).lengthSqr() < PARAMS::BUSTER::MoveUnitSqr)
                {
                    buster->invalidateTarget();
                    goScouting(buster);
                }
            }
            
            //choose if keeping the same target is smart
            if(buster->IsTargetContested() && buster->Target() != nullptr)
            {
                int tagCnt = buster->Target()->TagCounter();
                int ghostValue = buster->Target()->Value() - (tagCnt);
                if(ghostValue < tagCnt)
                {
                    //We are too many aiming the same target, change target
                    buster->invalidateTarget();
                    bool isTargetTagged = false;
                    //first check for tag free targets
                    Ghost* closest = nullptr;
                    closest = getClosestEntity(buster, curMVPs, isTargetTagged, true);
                    if(closest != nullptr)
                    {
                        buster->setTarget(m_ghosts[closest->ID()]);
                        buster->setState(new BAI_CaptureGhost(buster, this));
                        //mark as already targetted
                    }
                    else
                    {
                        //no relevant target, go scout
                        goScouting(buster);
                    }
                    buster->setTargetContested(false);
                }
            }
            else
            {
                //looking for a target
                if(buster->Target() == nullptr)
                {
                    Ghost* closest = nullptr;
                    bool isTargetTagged = false;
                    closest = getClosestEntity(buster, curMVPs, isTargetTagged);
                    if(closest != nullptr)
                    {
                        if(isTargetTagged)
                        {
                            //find the Busters targeting closest found
                            LookForValuableTarget(buster, curMVPs, closest);
                        }
                        else
                        {
                            //target is already tagged but Buster is closer to target
                            CaptureGhost(buster, m_ghosts[closest->ID()]);
                        }
                    }
                }
            }
                
            const Vec2 b_pos = buster->Pos();
            
            if(buster->State() == BusterActiveState::CARRYING)
            {
                if(Vec2(b_pos - PARAMS::MAP::TeamBasePos).lengthSqr() > PARAMS::BUSTER::ReleaseMaxDistanceSqr)
                {
                    //GOTO base
                    if(b_pos.X() == PARAMS::MAP::TeamBasePos.X() || b_pos.Y() == PARAMS::MAP::TeamBasePos.Y())
                    {
                        MoveTo(buster, PARAMS::MAP::TeamBasePos);
                    }
                    else
                    {
                        bool isclosestToX = (abs(b_pos.X() - PARAMS::MAP::TeamBasePos.X()) < abs(b_pos.Y() - PARAMS::MAP::TeamBasePos.Y()));
                        
                        Vec2 destination = (isclosestToX) ? Vec2(PARAMS::MAP::TeamBasePos.X(), b_pos.Y()) : Vec2(b_pos.X(), PARAMS::MAP::TeamBasePos.Y());
                        
                        MoveTo(buster, destination);
                    }
                }
                else
                {
                    //ReleaseGhost
                    //m_ghosts.erase(buster->Target()->ID());
                    buster->invalidateTarget();
                    buster->setDestination(b_pos);
                    buster->setState(new BAI_ReleaseGhost(buster, this));
                }
            }
            else
            {
                if(buster->Target() == nullptr)
                {
                    //no target
                    if(Vec2(b_pos - buster->Destination()).length() <  PARAMS::BUSTER::MoveUnit)
                    {
                        //lets scout the area for new ones
                        if(!buster->HasUsedradar() && curTimeStamp > 10 && Vec2(b_pos - PARAMS::MAP::TeamBasePos).length() > 5000)
                            buster->setState(new BAI_UseRadar(buster, this));
                        else
                            goScouting(buster);
                    }
                    for(Ghost* e : curMVPs)
                    {
                        if(!isSomeoneCarryingGhost(e) && (!e->Tagged() || e->Stamina() == 0))
                        {
                            CaptureGhost(buster, m_ghosts[e->ID()]);
                        }
                    }
                }
                
                Ennemy* mvp = bestTarget(b_pos);
                if(mvp != nullptr && !isABusterAttacking(buster, mvp))
                {
                    //test if we will have recovered our zap before ennemy reaches base
                    size_t distanceToBase = Vec2(mvp->Pos() - PARAMS::MAP::EnnemyBasePos).length() - 2000;
                    size_t busterDistance = buster->getStunCD() * PARAMS::BUSTER::MoveUnit;
                    if(distanceToBase < 0) distanceToBase = 0;
                    if( distanceToBase > busterDistance)
                        Intercept(buster, mvp);
                    else
                        std::cerr << distanceToBase << " < " << busterDistance;
                }
                
                //handle Stun state, detect danger nearby
                if(buster->canStun())
                {
                    Ennemy* mvp2 = bestTarget(b_pos);
                    if(mvp2 != nullptr && !isABusterAttacking(buster, mvp2))
                    {
                        Intercept(buster, mvp2);
                    }
                    
                    Ennemy* closestEnnemy = closestVisibleEnnemy(b_pos);
                    if(closestEnnemy != nullptr)
                    {
                        Ennemy* otherEnnemy = nullptr;
                        if(isABusterAttacking(buster, closestEnnemy))
                        {
                            otherEnnemy = closestVisibleEnnemy(b_pos, closestEnnemy);
                            if(otherEnnemy != nullptr)
                            {
                                if(!isABusterAttacking(buster, otherEnnemy))
                                {
                                    Stun(buster, otherEnnemy);
                                }
                            }
                        }
                        else
                        {
                            Stun(buster, closestEnnemy);
                        }
                    }
                }
            }
            
            if(buster->AIState() == nullptr)
            {
                buster->ResetInnerAIState();
                goScouting(buster);
            }
        }
        std::cerr << buster->ID() << " finished is thinking." << std::endl;
    }
    
    void IncTimestamp()
    {
        ++curTimeStamp;
        PARAMS::GAME::curTS = curTimeStamp;
    }
    
    void IncScore()
    {
        ++curScore;
    }
    
    size_t TimeStamp() const { return curTimeStamp; }
    
    Ghost* GhostWithID(size_t id) { return m_ghosts[id]; }

    private:
    //list of all sighted entities
    Entities entities;
    
    GhostsMap m_ghosts;
    EnnemiesMap m_ennemies;
    BustersMap m_busters;
    
    //references to my busters
    std::vector<size_t> bustersIDs;
    
    //game timestamp mainly used for memory pool
    size_t curTimeStamp;
    size_t curScore;
    
    //Scout var
    size_t curScoutIndex;
    std::vector<Vec2> scoutPositions;
    
    const size_t BustersCount;
    const size_t GhostsCount;
};

void BAI_MoveTo::handle()
{
    std::cerr << "Buster " << m_context->ID() << " at " << m_context->Pos().toStr() <<  " going to " << m_context->Destination().toStr() << std::endl;
    std::cout << "MOVE " << m_context->Destination().toStr() << std::endl;
}

void BAI_UseRadar::handle()
{
    std::cerr << "Triggering radar " << std::endl;
    std::cout << "RADAR" << std::endl;
    m_context->setUsedRadar(true);
    dirty = true;
}

void BAI_Stun::handle()
{
    if(m_context->BadBuster() != nullptr)
    {
        std::cout << "STUN " << m_context->BadBuster()->ID() << std::endl;
        m_context->stunEnnemy(m_master->TimeStamp());
        dirty = true;
    }
    else
    {
        std::cerr << "can't Stun ennemy (no ref)" << std::endl;
        std::cout << "MOVE " << m_context->Destination().toStr() << std::endl;
    }
}

void BAI_ReleaseGhost::handle()
{
    std::cerr << m_context->ID() << " RELEASING " << m_context->Value() << std::endl;
    std::cout << "RELEASE" << std::endl;
    m_master->IncScore();
    dirty = true;
}

void BAI_CaptureGhost::handle()
{
    Vec2 fromTarget(m_context->Pos() - m_context->Target()->Pos());
        size_t distanceSqr = fromTarget.lengthSqr();
        std::cerr << m_context->ID() << " Capturing " << m_context->Target()->ID() << std::endl;
        if(distanceSqr < (PARAMS::BUSTER::BustRangeOUT * PARAMS::BUSTER::BustRangeOUT))
        {
            if(distanceSqr < (PARAMS::BUSTER::BustRangeIN * PARAMS::BUSTER::BustRangeIN))
            {
                //Too close
                std::cout << "MOVE " << (fromTarget.normalize() * ((PARAMS::BUSTER::BustRangeIN + PARAMS::BUSTER::BustRangeOUT)/2)).toStr() << std::endl;
            }
            else
            {
                //Can Bust
                std::cout << "BUST " << m_context->Target()->ID() << std::endl; // MOVE x y | BUST id | RELEASE
                if(m_master->TimeStamp() - m_context->Target()->TimeStamp() > 0)
                {
                    //Target lost
                    std::cerr << "target disappeared :(" << std::endl;
                    m_context->setDestination(m_context->Target()->Pos());
                    m_context->setState(new BAI_MoveTo(m_context, m_master));
                }
            }
        }
        else
        {
            //Too Far
            std::cout << "MOVE " << m_context->Target()->Pos().toStr() << std::endl;
        }
}

bool BAI_CaptureGhost::isDirty()
{
    if(m_context->Target() == nullptr)
        return true;
        
    dirty = m_master->isSomeoneCarryingGhost(m_context->Target());
        
    return dirty;
}

void BAI_InterceptEnnemy::handle()
{
    Vec2 fromTarget(m_context->Pos() - m_context->BadBuster()->Pos());
        size_t distanceSqr = fromTarget.lengthSqr();
        std::cerr << m_context->ID() << " Intercepting " << m_context->BadBuster()->ID() << " distance : " << fromTarget.length() << std::endl;
        if(distanceSqr < PARAMS::BUSTER::StunDistanceSqr && m_context->canStun())
        {
            Vec2 e_pos = m_context->BadBuster()->Pos();
            int m_ghost_id = m_context->BadBuster()->Value();
            std::cout << "STUN " << m_context->BadBuster()->ID() << std::endl;
            m_context->stunEnnemy(m_master->TimeStamp());
            dirty = true;
        }
        else
        {
            //Too Far
            if(m_master->TimeStamp() - m_context->BadBuster()->TimeStamp() < 5)
            {
                Vec2 newPos (m_context->BadBuster()->Pos().X()*.5 + PARAMS::MAP::EnnemyBasePos.X()*.5, m_context->BadBuster()->Pos().Y()*.5 + PARAMS::MAP::EnnemyBasePos.Y()*.5);
                std::cout << "MOVE " << newPos.toStr() << std::endl;
            }
            else
            {
                Vec2 fromEnnemyBase(m_context->Pos() - PARAMS::MAP::EnnemyBasePos);
                Vec2 newPos (fromEnnemyBase.normalize() * (PARAMS::BUSTER::MoveUnit * 3));
                std::cout << "MOVE " << newPos.toStr() << std::endl;
            }
        }
        if(m_master->TimeStamp() - m_context->BadBuster()->TimeStamp() > 15)
        {
            dirty = true;
        }
}

int main()
{
    {
        int bustersPerPlayer; // the amount of busters you control
        std::cin >> bustersPerPlayer; std::cin.ignore();
        int ghostCount; // the amount of ghosts on the map
        std::cin >> ghostCount; std::cin.ignore();
        int myTeamId; // if this is 0, your base is on the top left of the map, if it is one, on the bottom right
        std::cin >> myTeamId; std::cin.ignore();
        
        PARAMS::GAME::BustersPerPlayer = bustersPerPlayer;
        PARAMS::GAME::GhostCount = ghostCount;
        PARAMS::GAME::TeamID = myTeamId;
        
        std::cerr << "Game Parameters (TeamID - GhostCount - BPP) : " << PARAMS::GAME::TeamID << " - " <<  PARAMS::GAME::GhostCount << " - " << PARAMS::GAME::BustersPerPlayer << std::endl;
    }
    
    if(PARAMS::GAME::TeamID == 0) {
        PARAMS::MAP::TeamBasePos = PARAMS::MAP::topLeft;
        PARAMS::MAP::EnnemyBasePos = PARAMS::MAP::bottomRight;
    }
    else
    {
        PARAMS::MAP::TeamBasePos = PARAMS::MAP::bottomRight;
        PARAMS::MAP::EnnemyBasePos = PARAMS::MAP::topLeft;
    }
    
    BusterAIMaster AIMaster(PARAMS::GAME::BustersPerPlayer * 2, PARAMS::GAME::GhostCount);

    // game loop
    while (1) {
        AIMaster.IncTimestamp();
        std::cerr << "------------------ Turn : " << AIMaster.TimeStamp() << std::endl;
        
        int entities; // the number of busters and ghosts visible to you
        std::cin >> entities; std::cin.ignore();
        for (int i = 0; i < entities; i++) {
            int entityId; // buster id or ghost id
            int x;
            int y; // position of this buster / ghost
            int entityType; // the team id if it is a buster, -1 if it is a ghost.
            int state; // For busters: 0=idle, 1=carrying a ghost.
            int value; // For busters: Ghost id being carried. For ghosts: number of busters attempting to trap this ghost.
            std::cin >> entityId >> x >> y >> entityType >> state >> value; std::cin.ignore();
            
            Vec2 pos(x,y);
            Entity entity(entityId, entityType, pos, state, value);
            //update sighted entity
            AIMaster.Update(entity, state);
        }
        
        AIMaster.HandleBusters();
    }
}