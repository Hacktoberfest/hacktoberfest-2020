(function() {
  var mode = localStorage.getItem('mode');
  window.mode = mode;
  
  // // A variable to store user information, not exposed publicly
  // var userData,
  //   prefix = '',
  //   currentUser = {};

  // currentUser.initData = function(data) {
  //   // Set the data, clear the timer, resolve promise
  //   userData = data;
  // };

  // currentUser.getData = function() {
  //   return userData || null;
  // };

  // currentUser.getPreference  = function(key) {
  //   if (!userData) { return; }

  //   return userData.data.attributes.preferences[key];
  // };

  // currentUser.updatePreference = function(key, value) {
  //   if (!userData) {
  //     return $.Deferred().reject(new Error('No current user data'));
  //   }

  //   // Set up data object
  //   var preferences = {};
  //   preferences[key] = value;

  //   // Post to server
  //   var updatePromise = $.ajax(prefix + '/api/users/' + userData.data.id, {
  //     method: 'PATCH',
  //     data: {
  //       data: {
  //         attributes: {
  //           preferences: preferences
  //         }
  //       }
  //     }
  //   });

  //   // Once the Ajax request successfully completes, save the new user data
  //   updatePromise.then(function(newData) {
  //     userData = newData;
  //   });

  //   return updatePromise;
  // };

  // // Expose the currentUser object
  // window.currentUser = currentUser;

  // $(function() {
  //   prefix = $(document.body).attr('data-prefix');
  // });
})();