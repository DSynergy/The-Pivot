$(document).ready(function(){
var states = $('.dynamic_search').data('search').states

// constructs the suggestion engine
var bloodhound = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  // `states` is an array of state names defined in "The Basics"
  local: $.map(states, function(state) { return { value: state }; })
});

// kicks off the loading/processing of `local` and `prefetch`
bloodhound.initialize();

$('.typeahead').typeahead({
  hint: false,
  highlight: true,
  minLength: 1
},
{
  name: 'states',
  displayKey: 'value',
  // `ttAdapter` wraps the suggestion engine in an adapter that
  // is compatible with the typeahead jQuery plugin
  source: bloodhound.ttAdapter()
});

});
