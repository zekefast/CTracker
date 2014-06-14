jQuery ->
  $.ajax(
    url: "/charts.json",
    success: (dataset) ->
      data =
        labels: dataset.labels,
        datasets: [
          {
            fillColor : "rgba(151,187,205,0.5)",
            strokeColor : "rgba(151,187,205,1)",
            pointColor : "rgba(151,187,205,1)",
            pointStrokeColor : "#fff",
            data : dataset.data
          }
        ]

      new Chart($("#canvas").get(0).getContext("2d")).Line(data)
  )
