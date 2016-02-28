function getAndSetSubscriberData() {
  function setSubscriberData(subscriberData) {
    var subscriber = subscriberData;
    localStorage.setItem("subUid", subscriber._id);
  }

  $.get("/subscriber/profile/my-info", function (data) {
    setSubscriberData(data);
  }, "json");
}