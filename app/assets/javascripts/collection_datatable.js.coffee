jQuery ->
  $("#collection").dataTable(
    sPaginationType: "full_numbers"
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    sAjaxSource: $("#collection").data("source")
    aoColumnDefs: [
      bSortable: false,
      aTargets: [0]
    ]
  )
