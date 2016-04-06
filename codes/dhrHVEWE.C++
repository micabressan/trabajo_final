if(this->m_PlayerControllerState->connected) {
	Lucidity::Input::Analog1dValue leftTrigger = this->m_PlayerControllerState->leftTrigger;
	Lucidity::Input::Analog1dValue rightTrigger = this->m_PlayerControllerState->rightTrigger;

	Lucidity::Input::Analog2dValue leftStick = this->m_PlayerControllerState->leftStick;
	Lucidity::Input::Analog2dValue rightStick = this->m_PlayerControllerState->rightStick;

	int controllerX = leftStick.x - (255 / 2);
	int controllerY = leftStick.y - (255 / 2);
	int rightControllerX = rightStick.x - (255 / 2);

	if(controllerX > -CONTROLLER_DEAD_ZONE && controllerX < CONTROLLER_DEAD_ZONE) {
		controllerX = 0;
	};

	if(controllerY > -CONTROLLER_DEAD_ZONE && controllerY < CONTROLLER_DEAD_ZONE) {
		controllerY = 0;
	};

	if(rightControllerX > -CONTROLLER_DEAD_ZONE && rightControllerX < CONTROLLER_DEAD_ZONE) {
		rightControllerX = 0;
	};

	float moveX = ((controllerX / 255.0f) * 2.0f);
	float moveZ = ((controllerY / 255.0f) * 2.0f);
	float rotation = ((rightControllerX / 255.0f) * 2.0f);

	moveX *= (delta / 1000) * PLAYER_SIDE_MOTION;
	moveZ *= (delta / 1000) * PLAYER_FORWARD_MOTION;
	rotation *= 90 * (delta / 1000);

	float currentX = this->m_Transform->GetPositionX();
	float currentZ = this->m_Transform->GetPositionZ();
	float currentRotation = this->m_Transform->GetRotationY();

	float xDeltaForwardMotion = moveZ * sin(currentRotation * (glm::pi<float>() / 180.0f));
	float zDeltaForwardMotion = moveZ * cos(currentRotation * (glm::pi<float>() / 180.0f));

	xDeltaForwardMotion += moveX * sin((currentRotation + 90) * (glm::pi<float>() / 180.0f));
	zDeltaForwardMotion += moveX * cos((currentRotation + 90) * (glm::pi<float>() / 180.0f));

	currentX += xDeltaForwardMotion;
	currentZ += zDeltaForwardMotion;

	currentRotation -= rotation;

	this->m_Transform->SetRotationY(currentRotation);
	this->m_Transform->SetPosition(currentX, this->m_Transform->GetPositionY(), currentZ);
}