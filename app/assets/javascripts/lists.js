
$(document).on('turbolinks:load', function(){
  console.log('It works on each visit!');
  $('.logo2').hide();
  filterTelefonesList();
  autocomplete();
  autocomplete2();
  autocompletejs();
})
  
//----------------------------------------------------------------------
  
  function autocomplete(){

     var lists = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.whitespace,
        queryTokenizer: Bloodhound.tokenizers.whitespace,

        remote: {
            url: '../autocomplete?keywords=%KEYWORDS',
            wildcard: '%KEYWORDS'
        },
    });

    var promise = lists.initialize();

    promise
        .done(function() { console.log('success!'); })
        .fail(function() { console.log('err!'); });

   $('.typeahead').typeahead({
      hint: true,
      highlight: true,
      autoselect: true,
      minLength: 1
    },
    {
        source: lists.ttAdapter()
    });

   $('.typeahead').on('typeahead:selected', function(obj,datum) {
    $( 'button' ).trigger('click');
  });
}

//----------------------------------------------------------------------

function autocomplete2(){

    var names = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.whitespace,
        queryTokenizer: Bloodhound.tokenizers.whitespace,

        prefetch: {ttl: 1, cache: false, url:'../colabs.json'}, cache: false

        //local: names

    });

    var promise = names.initialize();

    promise
        .done(function() { console.log('success!'); })
        .fail(function() { console.log('err!'); });

  localStorage.clear();
   $('.typeahead2').typeahead({
      hint: true,
      highlight: true,
      autoselect: true,
      minLength: 1
    },
    {
        source: names.ttAdapter()
    });
}

//------------------------------------------------------------------------

function filterTelefonesList(){
  tels = $('#list_telefones_attributes_0_telefone').html();
  rams = $('#list_telefones_attributes_0_ramal').html();
  $('#list_setor').change(function(){
    setor = $('#list_setor :selected').text();
    optgroup = "optgroup[label='"+ setor + "']";
    optgroup2 = "optgroup[label='"+ setor + "']";
    options = $(tels).filter(optgroup).html();
    options2 = $(rams).filter(optgroup2).html();

    if(setor != ""){
      $('#list_telefones_attributes_0_telefone').html(options);
      $('#list_telefones_attributes_0_ramal').html(options2);
    }
  });

  $('#list_setor').text(function(){
    setor = $('#list_setor :selected').text();
    optgroup = "optgroup[label='"+ setor + "']";
    //optgroup2 = "optgroup[label='"+ setor + "']";
    options = $(tels).filter(optgroup).html();
    //options2 = $(rams).filter(optgroup2).html();

    if(setor != ""){
      $('#list_telefones_attributes_0_telefone').html(options);
      //$('#list_telefones_attributes_0_ramal').html(options2);
    }
  });

  $('#list_setor').change(function(){
    id = $('#list_telefones_attributes_0_telefone :selected').text();
    var lastFour = id.substr(id.length - 4);
    console.log(lastFour)
    $('#list_telefones_attributes_0_ramal').val(lastFour);
  });
  $('#list_telefones_attributes_0_telefone').change(function(){
    id = $('#list_telefones_attributes_0_telefone :selected').text();
    var lastFour = id.substr(id.length - 4);
    console.log(lastFour)
    $('#list_telefones_attributes_0_ramal').val(lastFour);
  });
}

//-----------------------------------------------------------------------

    function autocompletejs(){
      if (window.location.href == "http://localhost:3000/" || window.location.href == "http://localhost:3000/admin"){
        
        setInterval(function() {
        l = $('#lists_search').val();
        if (l == ''){
          $('.searchable-container .items').hide();
          $('.logo2').show();
        }
      }, 500);
      }
      $('#lists_search').on('keyup', function() {
        $('.logo2').hide();
        var rex = new RegExp($(this).val(), 'i');
          $('.searchable-container .items').hide();
          $('.searchable-container .items').filter(function() {
            return rex.test($(this).text());
          }).show();
        });
}