export const ADD_USER_ID = 'ADD_USER_ID';
export const addUserId = userId => {
  return {
    type: ADD_USER_ID,
    userId
  };
};

export const ADD_USER_NAME = 'ADD_USER_NAME';
export const addUserName = userName => {
  return {
    type: ADD_USER_NAME,
    userName
  };
};

export const ADD_USER_EMAIL = 'ADD_USER_EMAIL';
export const addUserEmail = userEmail => {
  return {
    type: ADD_USER_EMAIL,
    userEmail
  };
};

export const ADD_LESSON_PACKS = 'ADD_LESSON_PACKS';
export const addLessonPacks = lessonPacks => {
  return {
    type: ADD_LESSON_PACKS,
    lessonPacks
  };
};
