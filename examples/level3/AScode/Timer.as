    _root.createTextField("tf", 0,30,30,500,70);
    _root.tf.border = true;
    _root.tf.embedFonts = false;
    _root.tf.type = 'input';
    _root.tf.multiline = true;
    _root.tf.wordWrap = true;
    _root.tf.background = true;
    _root.tf.backgroundColor = "912323";
    
    var myformat = new TextFormat();
    myformat.size = 22;
    myformat.font = '_sans';
    myformat.color = 990000;
    displayTime = function() {
    var today = new Date;
    _root.tf.text = today;
    _root.tf.setTextFormat(myformat);
    };
    var dtInterval = setInterval(displayTime, 1000);
