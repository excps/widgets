command: 'currency.widget/venv/bin/python3 currency.widget/stocks.py'

refreshFrequency: 7200000

style: """
  bottom: 80px
  left: 12px
  color: #fff
  font-family: Helvetica Neue
  font-size: 12px

  .title
    font-size: 1.6em
    font-weight: 200

  .content
    padding: .4em .6em
    font-size: 1.3em
    font-weight: 200
    background-color: rgba(64, 64, 64, 0.2)
    border-radius: 0.6em
    border: solid 1px rgba(64, 64, 64, 0.3)

  .label
    display: inline-block
    width: 4.6em
    color: #66cc22
    display: inline-block

  .value
    font-size: 1em
    line-height: 1.4em
    text-align: right
    display: inline-block
"""

render: -> """
  <div class="content"></div>
"""

update: (output, domEl) ->
  content = $(domEl).find(".content")
  content.empty()
  data = JSON.parse(output)
  for key,val of data
   content.append "<div><div class=\"label\">#{key}: </div> <div class=\"value\">#{val.in}</div> - <div class=\"value\">#{val.out}</div></div>"
