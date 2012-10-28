source = new EventSource("/subscribe")

source.addEventListener "picture", (event) ->
  data = JSON.parse(event.data)
  $("body, input").trigger "changeBackground", [data.url, data.keyword]

jQuery ->
  $("body").bind "changeBackground", (event, url, keyword) ->
    $(this).css(
      "background":              "url(#{url}) no-repeat center center fixed"
      "-webkit-background-size": "cover"
      "-moz-background-size":    "cover"
      "background-size":         "cover"
    )

  $("input").bind "changeBackground", (event, url, keyword) ->
    $(this).val("").attr("placeholder", keyword)

  $("form").submit (event) ->
    event.preventDefault()
    input = $(this).find("input")
    $.post "/publish", keyword: input.val()

  $("input").focus()
