command: '/opt/homebrew/bin/python3 ./stocks.widget/stocks.py'

refreshFrequency: 28800

style: """
  bottom: 400px
  left: 20px
  color: #fff
  font-family: Helvetica Neue
  font-size: 14px
  
  .title
    font-size: 1.6em
    font-weight: 200

  .content
    padding: .6em
    font-size: 1.3em
    font-weight: 200
    background-color: rgba(64, 64, 64, 0.2)
    border-radius: 0.6em
    border: solid 1px rgba(64, 64, 64, 0.3)

  .label
    display: inline-block
    width: 5em
    color: #66cc22

  .value
    font-size: 1em
    line-height: 1.4em
    text-align: right
"""

render: -> """
  <div class="content"></div>
"""

update: (output, domEl) ->
  content = $(domEl).find(".content")
  content.empty()
  data = JSON.parse(output)
  for key,val of data
   content.append "<div><span class=\"label\">#{key}: </span> <span class=\"value\">#{val}</span></div>"
