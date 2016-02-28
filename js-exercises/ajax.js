function setClickEventTrackers() {

  $(document).ready(function() {

    $(".publisher-url").click(function(event) {
      var productId = $(this).parent().attr("id");

      purchase_click_event = {
        product_id: productId,
        subscriber_id: localStorage.getItem("subUid"),
        referrer: document.URL,
        collection: "publisher_url_clicks",
        timestamp: new Date().toISOString()
      };

      $.ajax({
        type: "POST",
        url: "/subscriber/events/track-clicks",
        data: purchase_click_event,
        success: function(data, textStatus, jqXHR){},
        error: function (jqXHR, textStatus, errorThrown){},
        dataType: "json"
      });
    });

    $(".fitg-publisher-url").click(function(event) {
      var productId = $(this).attr("id");

      purchase_click_event = {
        product_id: productId,
        subscriber_id: localStorage.getItem("subUid"),
        referrer: "fill_in_the_gap",
        collection: "publisher_url_clicks",
        timestamp: new Date().toISOString()
      };
      
      $.ajax({
        type: "POST",
        url: "/subscriber/events/track-clicks",
        data: purchase_click_event,
        success: function(data, textStatus, jqXHR){},
        error: function (jqXHR, textStatus, errorThrown){},
        dataType: "json"
      });
    });

    $(".read-full-review").click(function(event) {
      var productId = $(this).parent().attr("id");

      editorial_review_click_event = {
        product_id: productId,
        subscriber_id: localStorage.getItem("subUid"),
        referrer: document.URL,
        collection: "editorial_review_clicks",
        timestamp: new Date().toISOString()
      };

      $.ajax({
        type: "POST",
        url: "/subscriber/events/track-clicks",
        data: editorial_review_click_event,
        success: function(data, textStatus, jqXHR){},
        error: function(jqXHR, textStatus, errorThrown){},
        dataType: "json"
      });
    });

    $(".questionnaire a").click(function(event) {
      var productId = $(this).parent().attr("id");

      publisher_questionnaire_click_event = {
        product_id: productId,
        subscriber_id: localStorage.getItem("subUid"),
        referrer: document.URL,
        collection: "publisher_questionnaire_url_clicks",
        timestamp: new Date().toISOString()
      };

      $.ajax({
        type: "POST",
        url: "/subscriber/events/track-clicks",
        data: publisher_questionnaire_click_event,
        success: function(data, textStatus, jqXHR){},
        error: function(jqXHR, textStatus, errorThrown){},
        dataType: "json"
      });
    });

    $("#questionnaire-row td a").click(function(event) {
      var productId = $(this).parent().attr("id");

      publisher_questionnaire_click_event = {
        product_id: productId,
        subscriber_id: localStorage.getItem("subUid"),
        referrer: document.URL,
        collection: "publisher_questionnaire_url_clicks",
        timestamp: new Date().toISOString()
      };

      $.ajax({
        type: "POST",
        url: "/subscriber/events/track-clicks",
        data: publisher_questionnaire_click_event,
        success: function(data, textStatus, jqXHR){},
        error: function(jqXHR, textStatus, errorThrown){},
        dataType: "json"
      });
    });

    $(".fitg-link").click(function(event) {
      var productId = $(this).attr("id");
      var referrerProductId = $(".read-full-review").parent().attr("id");
      fitg_click_event = {
        fitg_product_id: productId,
        product_id: referrerProductId,
        subscriber_id: localStorage.getItem("subUid"),
        referrer: "product",
        collection: "fill_in_the_gap_clicks",
        timestamp: new Date().toISOString()
      };

      $.ajax({
        type: "POST",
        url: "/subscriber/events/track-clicks",
        data: fitg_click_event,
        success: function(data, textStatus, jqXHR){},
        error: function(jqXHR, textStatus, errorThrown){},
        dataType: "json"
      });
    });
  });
}