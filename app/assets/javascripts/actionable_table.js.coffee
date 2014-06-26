jQuery ->
  $("input:checkbox.actionable").change ->
    checked = @checked
    $.ajax
      url: "/countries/#{@value}",
      type: "PATCH",
      contentType: "application/json; charset=utf-8"
      dataType: "json"
      data: JSON.stringify
        id: @value
        country_form_object:
          visited: @checked
      context: $("#row#{@value}")
      beforeSend: ->
        this.addClass("in-progress")
      complete: ->
        this.removeClass("in-progress")
      success: (response, textStatus, jqXhr) ->
        this.find(".status").text ->
          if checked
            "Visited"
          else
            "Not Visited"

        statuses    = $(".status")
        total       = statuses.size()
        visited     = statuses.filter( -> $(this).text() == "Visited").size()
        not_visited = total - visited

        $('.simple_pie_chart').html $("<table><tr><th>Visited</th><td>#{visited}</td></tr><tr><th>Not Visited</th><td>#{not_visited}</td></tr></table>")
        $('.simple_pie_chart').each ->
          SimplePieChart.initialize(this)
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("The following error occured: " + textStatus, errorThrown)

  $("#select_all").change ->
    $("input:checkbox.actionable:visible").prop("checked", @checked)

  $("#send_all").click ->
    $(".fade").each ->
      status  = $(this).find(".status").text()

      $(this).find("input:checkbox.actionable:visible").each ->
        checked = $(this).prop("checked")

        if (checked && status == "Not Visited") || (!checked && status == "Visited")
          $(this).trigger("change")

  $("#search").keyup ->
    regex = new RegExp @value, "i"
    $("#list tr.fade").each ->
      name = $(this).find(".name").text()
      code = $(this).find(".code").text()

      if name.match(regex) || code.match(regex)
        $(this).show()
      else
        $(this).hide()
