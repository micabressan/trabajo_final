#pragma once
#pragma pack(push,1)

#define DLLEXP __declspec(dllexport)

class UEngine;
class UWorld;

struct DynMatrix
{
	float m[16];
};

struct DynVector3
{
	float v[3];
};

struct DynQuat
{
	float v[4];
};

struct DynTransform
{
	DynVector3 Translation;
	DynQuat Rotation;
	DynVector3 Scale;
};

typedef const char* String;
typedef unsigned int Key;
typedef unsigned int ActorKey;
typedef unsigned int PlayerKey;

enum EActorType
{
	ACTOR_MESH,
	ACTOR_MESH_INSTANCED,
	ACTOR_PARTICLE,
	ACTOR_CHARACTER,
	ACTOR_CAMERA,
	ACTOR_HUD,
};

extern "C"
{
	DLLEXP void		dynAPI_Init(UEngine* engine, UWorld* world);
	DLLEXP void		dynAPI_Destroy();

	DLLEXP void		dynMath_TransformSetIdentity(DynTransform& transform);
	DLLEXP void		dynMath_TransformSetTranslation(DynTransform& transform, float x, float y, float z);
	DLLEXP void		dynMath_TransformSetScale(DynTransform& transform, float x, float y, float z);
	DLLEXP void		dynMath_TransformSetRotationEuler(DynTransform& transform, float pitch, float yaw, float roll);
	DLLEXP void		dynMath_TransformSetRotationAxisAngle(DynTransform& transform, float axisX, float axisY, float axisZ, float axisRotationRad);
	DLLEXP void		dynMath_TransformConcat(DynTransform& transform, DynTransform& transformConcatWith);
	DLLEXP void		dynMath_TransformInverse(DynTransform& transform, float eulerX, float eulerY, float eulerZ);

	DLLEXP void		dynDebug_Message(const char* message, float r, float g, float b, float a, float duration);

	DLLEXP ActorKey	dynActor_Create(EActorType type, DynVector3& translation, DynVector3& rotationEuler);
	DLLEXP bool		dynActor_Destroy(ActorKey actorID);

	DLLEXP void		dynPlayer_SetViewTarget(PlayerKey playerID, ActorKey actorCameraID);
	DLLEXP bool		dynPlayer_IsPressed(PlayerKey playerID, const char* key);
	DLLEXP bool		dynPlayer_WasPressed(PlayerKey playerID, const char* key);
	DLLEXP bool		dynPlayer_WasReleased(PlayerKey playerID, const char* key);
	DLLEXP float	dynPlayer_GetAxisValue(PlayerKey playerID, const char* key);
	DLLEXP float	dynPlayer_GetMouseX(PlayerKey playerID);
	DLLEXP float	dynPlayer_GetMouseY(PlayerKey playerID);
	DLLEXP float	dynPlayer_GetMouseDeltaX(PlayerKey playerID);
	DLLEXP float	dynPlayer_GetMouseDeltaY(PlayerKey playerID);
	DLLEXP void		dynPlayer_Possess(PlayerKey playerID, ActorKey actorPawnID);
	DLLEXP void		dynPlayer_Unpossess(PlayerKey playerID);
	DLLEXP void		dynPlayer_SetHUD(PlayerKey playerID, ActorKey actorHUDID);
	DLLEXP void		dynPlayer_ResetHUD(PlayerKey playerID);

	DLLEXP int		dynActorMeshInstanced_AddInstance(ActorKey actorID, DynTransform& trans, bool inTransformInWorldSpace = false);
	DLLEXP void		dynActorMeshInstanced_ClearInstances(ActorKey actorID);
	DLLEXP bool		dynActorMeshInstanced_RemoveInstance(ActorKey actorID, int inst);
	DLLEXP bool		dynActorMeshInstanced_GetInstanceTransform(ActorKey actorID, int inst, DynTransform& outTransform, bool inTransformInWorldSpace = false);
	DLLEXP bool		dynActorMeshInstanced_SetInstanceTransform(ActorKey actorID, int inst, DynTransform& inTransform, bool inTransformInWorldSpace = false, bool inMarkRenderStateDirty = false);

	DLLEXP void		dynActor_SetSource(ActorKey actorID, String source);
	DLLEXP void		dynActor_SetCollision(ActorKey actorID, bool enabled);
	DLLEXP void		dynActor_SetTransform(ActorKey actorID, DynTransform& matrix);
	DLLEXP void		dynActor_GetTransform(ActorKey actorID, DynTransform& matrix);
}

#pragma pack(pop)