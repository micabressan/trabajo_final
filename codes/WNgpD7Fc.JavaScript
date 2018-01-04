function lambdaHandler(action) {
  const sagaMiddleware = createSagaMiddleware()
  const store = createStore(
    reducer,
    applyMiddleware(sagaMiddleware)
  )
  const sagas = {
    CLICK_BUTTON: clickButtonSaga
  };
  const saga = sagas[action.type];
  sagaMiddleware.run(saga, action);

}