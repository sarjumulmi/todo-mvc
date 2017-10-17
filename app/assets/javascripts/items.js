function Item(attributes){
  this.description = attributes.description
  this.id = attributes.id
}

Item.prototype.renderLi = function() {
  return Item.template(this)
}

Item.prototype.destroy = function() {
  // debugger
  $('li#item_'+this.id).remove()
}

$(function() {
  Item.template = Handlebars.compile($('#item-template').html())

  $('form#new_item').on('submit', function(evt){
    evt.preventDefault()
    var $form = $(this)
    var action = $form.attr('action')
    var params = $form.serialize()
    $.ajax({
      url: action,
      data: params,
      method: 'POST',
      dataType: 'json'
    })
    .success(function(json){
      var item = new Item(json)
      var itemLi = item.renderLi()
      $('.todo-list').append(itemLi)
      $('input#item_description').val('')
    })
    .error(function(error) {
      console.log(`You broke it. ${error}`)
    })
    // could make the success and error cbs as class method on Item
    // Item.success = function(json){
    //   var item = new Item(json)
    //   var itemLi = item.renderLi()
    //   $('.todo-list').append(itemLi)
    //   $('input#item_description').val('')
    // }
    // .success(Item.success) => call success cb
    // debugger
  })
  // delete via ajax and EVENT DELEGATION
  // $('form.button_to input.destroy').on('click', function(e){ => too generic because of event delegation and input destroy being removed and added
  $('ul.todo-list').on('click', 'input.destroy', function(e){
    e.preventDefault()
    // alert('delete???')
    // debugger
    var $form = $(this).parent('form')
    var action = $form.attr('action')
    var params = $form.serialize()
    // debugger
    $.ajax({
      url: action,
      data: params,
      dataType: 'json',
      method: 'DELETE'
    })
    .success(function(json){
      // debugger
      var item = new Item(json)
      item.destroy()
    })
    .error(function(error){
      console.log('you broke with '+ error)
    })
  })

})
