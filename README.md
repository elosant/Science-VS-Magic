## Considerations:

* Processes that are not considered "high refresh rate" or do not manage a considerable amount of entities are found as scripts called "handlers".
* Each system contains the logic for a component, the system iterates through the entities associated with said component and are updated accordingly.
* Mediators, and some controllers, are used to relay an event to the relevant script. Controllers are mainly used to handle requests from another machine and propagate accordingly.

## Authors:

* Elosant