String changeIdOfCreatedPatch = "inject_and_replace_change_id"; // This comes through parameter of the script or something like that.

for (item in Hudson.instance.queue.items) {
	int queueItemId = item.getId();

	if (item.getAction(ParametersAction.class) != null) {
		if (item.isBlocked()){
			List < ParameterValue > parameters = item.getAction(ParametersAction.class).getParameters();

			String inQueueChangeId = "";
			for (parameter in parameters) {
				if (parameter.getName().equals("GERRIT_CHANGE_ID")) {
					inQueueChangeId = parameter.getValue();
					break;
				}
			}

			if (!inQueueChangeId.isEmpty() && !changeIdOfCreatedPatch.isEmpty()) {
				if (changeIdOfCreatedPatch.equals(inQueueChangeId)) {
					Hudson.instance.queue.doCancelItem(queueItemId);
				}
			}
		}
	}
}