SCOPED_EVENT("Tick all scenes");

// Add new scenes to the list
for (auto iter : mScenesToAdd)
{
	ASSERT(!mScenes.exists(iter));
	mScenes.push_back(iter);
}

// Remove old scenes from the list
for (auto iter : mScenesToDelete)
{
	ASSERT(!mScenes.exists(iter));
	mScenes.find_erase(iter);

	iter->Release();
	delete iter;
}

mScenesToAdd.clear();
mScenesToDelete.clear();

// Tick all scenes
for (auto iter : mScenes)
	iter->Tick();