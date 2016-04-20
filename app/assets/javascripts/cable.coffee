@App ||= {}
App.cable = ActionCable.createConsumer("http://192.168.31.249:3001")