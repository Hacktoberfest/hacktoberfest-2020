import { combineReducers } from 'redux';

const userState = {
  userId: '',
  userFirstName: '',
  userLastName: '',
  userEmail: ''
};

const lessonState = {
  lessonPacks: []
};

const userReducer = (state = userState, action) => {
  switch (action.type) {
    case 'ADD_USER_NAME':
      return Object.assign({}, state, {
        userFirstName: action.first_name,
        userLastName: action.last_name
      });
    case 'ADD_USER_EMAIL':
      return Object.assign({}, state, {
        userEmail: action.userEmail
      });
    case 'ADD_USER_ID':
      return Object.assign({}, state, {
        userId: action.userId
      });
    default:
      return state;
  }
};

const lessonPackReducer = (state = lessonState, action) => {
  switch (action.type) {
    case 'ADD_LESSON_PACKS':
      return Object.assign({}, state, {
        lessonPacks: action.lessonPacks
      });
    default:
      return state;
  }
};

const rootReducer = combineReducers({ lessonPackReducer, userReducer });

export default rootReducer;
