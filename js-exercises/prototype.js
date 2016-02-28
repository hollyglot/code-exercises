function initializeLibraryCompareToolbarFunctions() {

  function setHeaderPosition() {
    if ($(window).scrollTop() < 264) {
      $('#compare-selection').css('position', 'absolute');

      // Increase search results top margin if header is visible
      if ($('#compare-selection').css('display') === 'block') {
        $('#compare-selection').css('top', '102px');
        $(".mp-content").css('margin-top', '55px');
      } else {
        $(".mp-content").css('margin-top', '0');
      }
    } else if ($(window).scrollTop() > 265) {
      $('#compare-selection').css('top', '0');
      $('#compare-selection').css('position', 'fixed');
      if ($('#compare-selection').css('display') === 'block') {
        $(".mp-content").css('margin-top', '55px');
      } else {
        $(".mp-content").css('margin-top', '0');
      }
    }
  }

  // Header bottom or top position changes by body scroll position
  $(window).scroll(function () {
    setHeaderPosition();
  });

  var imageIndex = 1; // set imageIndex as a global variable

  function setCompareImageGrid(clickedCheckbox) {
    var checkbox = $(clickedCheckbox);
    var image = checkbox.parent().parent().children(".mp-image").children("img").clone();
    var id = checkbox.val();

    // Append product image to compare header
    image.addClass('compare-image');
    $('.compare-image-' + imageIndex).append(image);
    $('.compare-image-' + imageIndex).data("id", id);

    // Display remove icon
    var remove = $('.compare-image-' + imageIndex).find('.remove');
    remove.css('display', 'block');
    imageIndex++;

  }

  function setCompareImageList(clickedCheckbox) {
    var checkbox = $(clickedCheckbox);
    var image = checkbox.parent().parent().children().first().children("img").clone();
    var id = checkbox.val();

    // Append product image to compare header
    image.addClass('compare-image');
    $('.compare-image-' + imageIndex).append(image);
    $('.compare-image-' + imageIndex).data("id", id);

    // Display remove icon
    var remove = $('.compare-image-' + imageIndex).find('.remove');
    remove.css('display', 'block');
    imageIndex++;

  }

  function toggleCompareHeader() {
    var checked = [];

    // Total checkboxes that are checked
    $('.compare-checkbox').each(function () {
      var checkbox = $(this);
      if (checkbox.prop('checked')) {
        checked[checked.length] = "yes";
      }
    });

    // If one compare checkbox is checked and the compare header isn't visible, display header.
    if (checked.length === 1) {
      $('#compare-selection').css("display", "block");

      // If all of the checkboxes have been unchecked, hide the compare header.
    } else if (checked.length === 0) {
      $('#compare-selection').css("display", "none");
    }
    setHeaderPosition();
  }

  function setProductCompareParameter(parameter, value) {
    var url = $("#compare-products").attr("href");
    var regPattern = parameter + "=nil";
    var isNil = url.match(new RegExp(regPattern));
    var newUrl = "";

    if (isNil === null) {
      var paramsReg = "\\[]=\\w+";
      var paramsExist = url.match(new RegExp(paramsReg));

      if (paramsExist) {
        newUrl = url.concat("&" + parameter + "[]=" + value);
        $("#compare-products").attr("href", newUrl);
      } else {
        newUrl = url.concat(parameter + "[]=" + value);
        $("#compare-products").attr("href", newUrl);
      }
    } else {
      newUrl = url.replace(new RegExp(regPattern), parameter + "[]=" + value);
      $("#compare-products").attr("href", newUrl);
    }
  }

  function setReportCompareParameter(parameter, value) {
    var url = $("#compare-reports").attr("href");
    var regPattern = parameter + "=nil";
    var isNil = url.match(new RegExp(regPattern));
    var newUrl = "";

    if (isNil === null) {
      var paramsReg = "\\[]=\\w+";
      var paramsExist = url.match(new RegExp(paramsReg));

      if (paramsExist) {
        newUrl = url.concat("&" + parameter + "[]=" + value);
        $("#compare-reports").attr("href", newUrl);
      } else {
        newUrl = url.concat(parameter + "[]=" + value);
        $("#compare-reports").attr("href", newUrl);
      }
    } else {
      newUrl = url.replace(new RegExp(regPattern), parameter + "[]=" + value);
      $("#compare-reports").attr("href", newUrl);
    }
  }

  function getProductId(clickedCheckbox) {
    var $checkbox = $(clickedCheckbox);
    var id = $checkbox.val();
    return id;
  }

  function getProductCheckbox(id) {
    var checkbox = document.querySelectorAll('input[value="' + id + '"]');
    return checkbox;
  }

  function updateCompareForm(clickedCheckbox) {
    // Set parameters
    var id = getProductId(clickedCheckbox);
    setProductCompareParameter("products", id);
    setReportCompareParameter("products", id);
  }

  function removeImage(clickedRemove) {
    var remove = $(clickedRemove);
    remove.parent().html(remove);
    remove.hide();
  }

  function removeProductCompareParameter(parameter, value) {
    var url = $("#compare-products").attr("href");
    var ampPatternBefore = "&" + parameter + "[]=" + value;
    var ampPatternAfter = parameter + "[]=" + value + "&";
    var ampPattern = parameter + "[]=" + value;
    var matchBefore = url.contains(ampPatternBefore);
    var newUrl;

    if (matchBefore) {
      newUrl = url.replace(ampPatternBefore, "");
    } else {
      var matchAfter = url.contains(ampPatternAfter);

      if (matchAfter) {
        newUrl = url.replace(ampPatternAfter, "");
      } else {
        newUrl = url.replace(ampPattern, "");
      }
    }
    $("#compare-products").attr("href", newUrl);
  }

  function removeReportCompareParameter(parameter, value) {
    var url = $("#compare-reports").attr("href");
    var ampPatternBefore = "&" + parameter + "[]=" + value;
    var ampPatternAfter = parameter + "[]=" + value + "&";
    var ampPattern = parameter + "[]=" + value;
    var matchBefore = url.contains(ampPatternBefore);
    var newUrl;

    if (matchBefore) {
      newUrl = url.replace(ampPatternBefore, "");
    } else {
      var matchAfter = url.contains(ampPatternAfter);

      if (matchAfter) {
        newUrl = url.replace(ampPatternAfter, "");
      } else {
        newUrl = url.replace(ampPattern, "");
      }
    }
    $("#compare-reports").attr("href", newUrl);
  }

  function removeParameters(clickedRemove) {
    var remove = $(clickedRemove);

    // Remove product id parameter
    var productId = remove.parent().data("id");
    removeProductCompareParameter("products", productId);
    removeReportCompareParameter("products", productId);
  }

  function uncheckCheckbox(clickedRemove) {
    var remove = $(clickedRemove);
    var productId = remove.parent().data("id");
    var checkbox = getProductCheckbox(productId);
    $(checkbox).attr('checked', false);
    toggleCompareHeader();
  }

  function moveImages(clickedRemove) {
    $(".image-container").each(function () {
      var container = $(this);
      var image = container.find("img");

      // If current container has no image
      if (image.length === 0) {

        // Find the next image
        var nextImage = container.next().find("img");

        // If next image exists
        if (nextImage.length > 0) {

          // Insert next container's html into current container
          container.html(container.next().html());

          // Copy next container's id to current container
          var id = container.next().data("id");
          container.data("id", id);

          // Set the next container's data id to nothing
          container.next().data("id", "");

          // Remove next container's image
          var remove = container.next().children(".remove");
          container.next().html(remove);

          // Hide next container's remove icon
          remove.hide();
        }
      }

    });
    var remove = $(clickedRemove);
    remove.parent().next().find("img");
  }

  function resetRemove() {
    unbindRemove();
    bindRemove();
  }

  function unSelectProductByRemoveIcon(remove) {
    removeImage(remove);
    removeParameters(remove);
    uncheckCheckbox(remove);
    moveImages();
    resetRemove();
    imageIndex--;
  }

  function getImageContainerById(id) {
    var imageContainer;
    $(".image-container").each(function () {
      var container = $(this);
      if (container.data("id")  === id) {
        imageContainer = container.get(0);
      }
    });
    if (imageContainer) {
      return imageContainer;
    }
  }

  function unSelectProductByCheckbox(clickedCheckbox) {
    var id = $(clickedCheckbox).val();
    var container = getImageContainerById(id);
    var remove = $(container).find(".remove");
    unSelectProductByRemoveIcon(remove.get(0));
  }

  $("#compare-dialog").dialog({
    autoOpen: false,
    appendTo: ".compare-dialog-container",
    minWidth: 350,
    show: {
      effect: "fade",
      duration: 250
    },
    hide: {
      effect: "fade",
      duration: 500
    }
  });

  // Add missing close icon. Jquery UI 1.10.3 issue.
  $(".ui-dialog-titlebar-close").html("<span class='ui-button-icon-primary ui-icon ui-icon-closethick'></span>");

  function unbindCheckbox() {
    $('.compare-checkbox').unbind("click");
  }

  function bindCheckbox() {
    $('.compare-checkbox').click(function () {

      var checkbox = $(this);
      toggleCompareHeader();

      if (checkbox.prop('checked')) {
        // If 3 products have been selected, display dialog and uncheck checkbox.
        if (imageIndex === 4) {
          $("#compare-dialog").dialog("open");

          // Uncheck checkbox
          $(this).attr('checked', false);
          return true;
        }
        setHeaderPosition();
        if ($(".font-icon-list").hasClass("active")) {
          setCompareImageList(this);
        } else {
          setCompareImageGrid(this);
        }

        updateCompareForm(this);
      } else {
        unSelectProductByCheckbox(this);
      }
    });
  }

  function unbindRemove() {
    $(".remove").unbind("click");
  }

  function bindRemove() {
    $('.remove').click(function () {
      unSelectProductByRemoveIcon(this);
    });
  }

  // IMPORTANT for when the page is loaded by Ajax from list view to grid view and back again.
  // The old click events will still be in the DOM causing the Compare Header to act buggy.
  unbindRemove();
  unbindCheckbox();

  bindCheckbox();
  bindRemove();

  //--------------------------------  SET CHECKBOXES ON DOM CHANGE --------------------

  function clickCheckbox(productId) {
    var checkbox = getProductCheckbox(productId);
    $(checkbox).prop("checked", true);
  }

  if ($(".compare-image-1").children("img").length > 0) {
    $('.image-container').each(function () {
      var container = $(this);
      if (container.children("img").length > 0) {
        imageIndex++;
        clickCheckbox(container.data("id"));
      }
    });
  }
}


// Create String.prototype.contains
if (!String.prototype.contains) {
  String.prototype.contains = function () {
    return String.prototype.indexOf.apply(this, arguments) !== -1;
  };
}