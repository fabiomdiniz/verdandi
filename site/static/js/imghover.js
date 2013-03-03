// On window load. This waits until images have loaded which is essential
$(window).load(function(){
    
    var fade_time = 300;

    // Fade in images so there isn't a color "pop" document load and then on window load
    $(".item img").fadeIn(500);
    
    // clone image
    $('.item img').each(function(){
        var el = $(this);
        el.css({"position":"absolute"}).wrap("<div class='img_wrapper' style='display: inline-block'>").clone().addClass('img_grayscale').addClass('inactive').css({"position":"absolute","z-index":"997","opacity":"0"}).insertBefore(el).queue(function(){
            var el = $(this);
            el.parent().css({"width":this.width,"height":this.height});
            el.dequeue();
        });
        this.src = this.src.substring(0, this.src.indexOf('.')) + '_bw' + '.png'//grayscale(this.src);
    });
    
    $("img.verdandi:not(.img_grayscale)").after("<h2 style=\"top:120px; z-index: 998; opacity: 0;\" class=\"hover_text\">Verðandi</h2>");
    $("img.urdr:not(.img_grayscale)").after("<h2 style=\"top:160px; z-index: 998; opacity: 0;\" class=\"hover_text\">Urðr</h2>");
    $("img.skuld:not(.img_grayscale)").after("<h2 style=\"top:200px; z-index: 998; opacity: 0;\" class=\"hover_text\">Skuld</h2>");

    $("img.urdr:not(.img_grayscale)").after("<h3 style=\"top:260px; z-index: 998; opacity: 0;\" class=\"hover_text\">Not Available Yet</h3>");
    $("img.skuld:not(.img_grayscale)").after("<h3 style=\"top:260px; z-index: 998; opacity: 0;\" class=\"hover_text\">Not Available Yet</h3>");

    $(".hover_text").wrapInner("<span>")

    $(".hover_text br").before("<span class='spacer'>").after("<span class='spacer'>");


    var desc = ['Norn of the present, easy AI', 'Norn of the fate, moderate AI', 'Norn of the future, advanced AI']    

    // Fade image 
    $('.item img.inactive, .hover_text').on('mouseover', function(){
        $(this).parent().find('img:first').stop().animate({opacity:1}, fade_time);
        $(this).parent().find('.hover_text').stop().animate({opacity:1}, fade_time);
        idx = $('.img_wrapper').index($(this).parent());
        $("#norn_desc").css('opacity', '1');
        $("#norn_desc").html(desc[idx])
    })
    $('.img_grayscale.inactive, .hover_text').on('mouseout', function(){
        if($(this).parent().find('img.img_grayscale').hasClass('inactive')) {
            $(this).parent().find('img.img_grayscale').stop().animate({opacity:0}, fade_time);
            $(this).parent().find('.hover_text').stop().animate({opacity:0}, fade_time);
        }
        $("#norn_desc").css('opacity', '0');
    });
});

// Grayscale w canvas method
function grayscale(src){
    var canvas = document.createElement('canvas');
    var ctx = canvas.getContext('2d');
    var imgObj = new Image();
    imgObj.src = src;
    canvas.width = imgObj.width;
    canvas.height = imgObj.height; 
    ctx.drawImage(imgObj, 0, 0); 
    var imgPixels = ctx.getImageData(0, 0, canvas.width, canvas.height);
    for(var y = 0; y < imgPixels.height; y++){
        for(var x = 0; x < imgPixels.width; x++){
            var i = (y * 4) * imgPixels.width + x * 4;
            var avg = (imgPixels.data[i] + imgPixels.data[i + 1] + imgPixels.data[i + 2]) / 3;
            imgPixels.data[i] = avg; 
            imgPixels.data[i + 1] = avg; 
            imgPixels.data[i + 2] = avg;
        }
    }
    ctx.putImageData(imgPixels, 0, 0, 0, 0, imgPixels.width, imgPixels.height);
    return canvas.toDataURL();
}
        