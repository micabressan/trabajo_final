final Map<String, Consumer<String>> actionMap = new HashMap<>();
Consumer<String> defaultAction = ...
// add actions to the map
actionMap.put("case 1", s -> { doSomething() });
actionMap.put("case 2", s -> { doSomething() });
actionMap.put("case 3", s -> { doSomething() });

// instead of switch
String action = ...
actionMap.getOfDefault(action, defaultAction).apply(action);