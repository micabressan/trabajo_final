#include "ScriptPCH.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"


Unit* Creature::SelectNearestHostileUnitInAggroRange(bool useLOS) const
{

    Unit* target = NULL;
    #define AGGRO_RANGE 30.0f  // yards

    {
        Trinity::NearestHostileUnitInAggroRangeCheck u_check(this, useLOS);
        Trinity::UnitSearcher<Trinity::NearestHostileUnitInAggroRangeCheck> searcher(this, target, u_check);

        VisitNearbyGridObject(AGGRO_RANGE, searcher);
    }

    return target;
}

class the_gnoul_army : public CreatureScript
{
public:
    the_gnoul_army() :CreatureScript("the_gnoul_army") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new the_gnoul_armyAI(creature);
    }

    struct the_gnoul_armyAI : public ScriptedAI
    {

        the_gnoul_armyAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
            Reset();   
        }

        CreatureAI* GetAI(Creature* creature) const
        {
            return new the_gnoul_armyAI(creature);
        }

        InstanceScript* instance;

        void Initialize()
        {

        }

        void EnterCombat(Unit* /*who*/) override
        {
            me->SetReactState(REACT_AGGRESSIVE);
        }

        void Reset() override
        {
            Initialize();
            me->SetReactState(REACT_AGGRESSIVE);
        }


        void UpdateAI(uint32 diff) override
        {
            if (Unit* target = me->SelectNearestHostileUnitInAggroRange(true))
                if (target->getLevel() <= 83)
                    DoCast(target, 56222);

            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;
            DoMeleeAttackIfReady();
        }

    };

};

void AddSC_boss_test()
{
    new the_gnoul_army();
}