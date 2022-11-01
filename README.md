VERY IMPORTANT NOTE THE UI DOES NOT FOLLOW THE PAYOUT TO A "T". because you only make a cut of what the company makes. As well as if you keep driving the meter keeps rising but your pay will not as not to be easily exploited.
Also note i am still working on the ridecall feature i havent got the menu part fully working yet but if you press e right away when the call comes in it will trace it.

```
exports['k-taxi']:NPCCall() -- puts an npc run into the clients table must be done client side

```
Make sure you add the job into qb-core shared jobs as well as qb-management and the sql

``` qb-radialmenu/config.lua replace the taxi section with this
    
["taxi"] = {
    {
        id = 'togglemeter',
        title = 'Show Meter',
        icon = 'eye',
        type = 'client',
        event = 'k-taxi:openmeter',
        shouldClose = false
    }, {
        id = 'civ_calls',
        title = 'Civ Call List',
        icon = 'taxi',
        type = 'client',
        event = 'k-taxi:civ_calls',
        shouldClose = true
    }, {
        id = 'npc_mission',
        title = 'Toggle Availability',
        icon = 'taxi',
        type = 'client',
        event = 'k-taxi:toggleavailable',
        shouldClose = true
    }, {
        id = 'npc_calls',
        title = 'Local Call List',
        icon = 'taxi',
        type = 'client',
        event = 'k-taxi:npc_calls',
        shouldClose = true
    }, {
        id = 'togglemouse',
        title = 'Hide Meter',
        icon = 'eye-slash',
        type = 'client',
        event = 'k-taxi:closemeter',
        shouldClose = true
    }
},