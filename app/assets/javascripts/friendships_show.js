// $(document).ready(function (){
//   $(document).on("click","#add_blog",function (){
//     $(this).parent().children("#show_form").toggle();
//     console.log($(this).parent());
//   })
// })

var ready = function(){
 $(".show_form").hide();
    $(document).on("click","#add_blog",function (){
      $(this).parent().children(".show_form").toggle();
    })
}
$(document).on('page:load',ready)
$(document).ready(ready)

// var ready = function(){
//  $(".show_form").hide();
//     $("#add_blog").on("click",function (){
//       console.log(this);
//       $(this).parent().children(".show_form").toggle();
//     })
// }
// $(document).on('page:load',ready)

