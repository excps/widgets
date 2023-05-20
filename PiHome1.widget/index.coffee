#-----------------------------------------------------------------------#
# raspberryData for Übersicht
# Created April 2020 by Johannes Hubig

host = 'home1'
user = 'pi'
logo = '../images/RPi-Logo-SCREEN.png'

# THEME OPTIONS: dark or light	(default is dark)

theme		= 'light'

# Position of the widget on your screen
pos_top		= '12px'
pos_left	= '12px'

#-----------------------------------------------------------------------#
width	= '320px'

if theme == 'dark'
  titleColor	= '#999999'
  infoColor		= '#CCCCCC'
  dataColor		= '#FFFFFF'
  lineColor		= '#b50039'
  barColor    = '#777777'
  bkground		= 'rgba(#000, 0.5)'

else if theme == 'light'
  titleColor	= '#333333'
  infoColor		= '#333333'
  dataColor		= '#555555'
  lineColor		= '#555555'
  barColor    = '#AAAAAA'
  bkground		= 'rgba(#999, 0.5)'

else
  titleColor	= '#999999'
  infoColor		= '#CCCCCC'
  dataColor		= '#FFFFFF'
  lineColor		= '#b50039'
  barColor    = '#777777'
  bkground		= 'rgba(#000, 0.5)'

command: "PiHome1.widget/getData.sh #{host} #{user} 2>/dev/null"

# Update every 60 seconds
refreshFrequency: 60000

style: """
  top:	#{pos_top}
  left:	#{pos_left}
  font-family: Avenir Next

  .clear 
    clear: both
  
  .top
    border: 1px solid #{lineColor}
    border-radius .5em
    background: #{bkground}
    font-size: 16px
    font-weight: 500
    width: #{width}

  .title
    margin: 12px
    width: 95%
    color: #{titleColor}
    border-spacing: 0

  .title .img-wrap
    display: inline-block
    float: left
    width: 20%
  
  .title .header
    font-size: 2em
    display: inline-block
    float: left
    width: 60%

  ul.section
    width: 100%
    margin: 4px 12px
    list-style-type: none
    padding: 0

  section
    width: 100%
    margin: 12px
    padding: 0

  .section li label
    font-size: 1em
    width: 25%
    display: inline-block
    color: #{infoColor}

  .section li value
    font-size: 0.9em
    text-align: right
    display: inline-block
    width: 65%  
    color: #{dataColor}

  

  tr.raspInfo
    font-size: 0.6em
    max-width: 100%
    color: #{infoColor}
    margin-left: 5px

  table.raspData
    margin-top: 0px
    margin-left: 5px
    font-size: 1em
    font-weight: 400
    width: 96%
    color: #{dataColor}

  .raspData tbody
    display: table
    width: 100%

  td.description
    width: 25%
    text-align: left

  td.value
    text-align: right

  td.sectionTitle
    font-weight: 700

  hr
    margin-left: 5px
    margin-right: 5px

  .progressbar
    width: 100%
    position: absolute
    height: 1em
    background: #{barColor}
    border-radius: 3px
    margin-top: 0px
    max-width: 300px

  .progressbar div
    background: #64B5F6
    border-radius: 3px
    position: absolute
    left: 0
    top: 0
    bottom: 0

  h1
    overflow: hidden
    text-align: center
    font-weight: 600
    font-size: 12px
    color: #{dataColor}
    margin-left: 5px
    margin-right: 5px
    margin-top: 2px
    margin-bottom: 2px

  h1:before, h1:after
    background-color: #FFF
    content: ""
    display: inline-block
    height: 1px
    position: relative
    vertical-align: middle
    width: 50%

  h1:before
    right: 0.5em
    margin-left: -50%

  h1:after
    left: 0.5em
    margin-right: -50%




"""

render: -> """
  <div class='top'>
    <div class='title'>
      <div class="img-wrap">
        <img src='#{logo}' height=35px/>
      </div>
      <div class='header'>
        #{host}.local
      </div>
      <div class='clear model'><span id='model'>N/A</span></div>
    </div>
    <h1 id='systemSection'>S Y S T E M</h1>
    <ul class='section'>
      <li>
        <label>OS</label>
        <value><span id='version'>N/A</span></value>
      </li>
      <li>
        <label>Kernel</label>
        <value><span id='kernelVersion'>N/A</span></value>
      </li>
      <li>
        <label>UP Since</label>
        <value><span id='uptime'>N/A</span></value>
      </li>
      <li>
        <label>IP Address</label>
        <value><span id='ipAddress'>N/A</span></value>
      </li>
    </ul>
    <h1 id='cpuSection'>C P U</h1>
      <ul class='section'>
        <li>
          <label>Model</label>
          <value><span id='cpuModel'>N/A</span></value>
        </li>
        <li>
          <label>Type</label>
          <value><span id='cpuType'>N/A</span></value>
        </li>
        <li>
          <label>Revision</label>
          <value><span id='cpuRevision'>N/A</span></value>
        </li>
        <li>
          <label>Temp</label>
          <value><span id='cpuTemp'>N/A</span></value>
        </li>
      </ul>
    <h1 id='usageSection'>U S A G E</h1>
      <ul class='section'>
        <li>
          <label>Running</label>
          <value><span id='runningProcs'>N/A</span></value>
        </li>
        <li>
          <label>Memory</label>
          <value><span id='memory'>N/A</span></value>
        </li>
        <li>
          <label>Disk</label>
          <value><span id='diskUsage'>N/A</span></value>
        </li>
        <li>
          <label>Open</label>
          <value><a href="https://#{host}.local:10000">#{host}.local</a></value>
        </li>
      </ul>
  </div>
  <div id="debug"></div>
"""

update: (output,domEl) ->
  values	= output.split("\n")
  div			= $(domEl)

  div.find('#systemSection').css("display", "block")
  div.find('#cpuSection').css("display", "block")
  div.find('#usageSection').css("display", "block")

  if values[0].includes("host not found")
    div.find('#systemSection').css("display", "none")
    div.find('#cpuSection').css("display", "none")
    div.find('#usageSection').css("display", "none")
    div.find('#errorLog').html("Host <span style='font-style: italic;'>" + values[2] + "</span> cannot be found.
    Please check the raspberryData.sh for correct hostname/ip.")

  else if values[0].includes("no ssh")
    div.find('#systemSection').css("display", "none")
    div.find('#cpuSection').css("display", "none")
    div.find('#usageSection').css("display", "none")
    div.find('#errorLog').html("The host <span style='font-style: italic;'>" + values[2] + "</span> doesn' support ssh
    or user <span style='font-style: italic;'>" + values[1] + "</span> is not existing or ssh-keys are not existing. Check readme.")

  else
    div.find('#errorSection').css("display", "none")

    div.find('#model').html(values[2])
    #OS
    div.find('#version').html(values[1])
    div.find('#kernelVersion').html("Linux " + values[7])
    div.find('#uptime').html(values[3])
    div.find('#ipAddress').html(values[6])
    #CPU
    div.find('#cpuModel').html(values[12])
    div.find('#cpuType').html(values[10])
    div.find('#cpuRevision').html(values[11])
    div.find('#cpuTemp').html(values[0] + " °C")
    #USAGE
    div.find('#runningProcs').html(values[9])
    div.find('#memory').html(parseInt(values[4]) + " of " + parseInt(values[5]) + " MB free&nbsp;")
    # Split disk usage output
    diskvalues	= values[8].split(" ")
    div.find('#diskUsage').html(diskvalues[3] + " of " + diskvalues[1] + " GB free&nbsp;")

    #div.find('#debug').html(output.toString())
