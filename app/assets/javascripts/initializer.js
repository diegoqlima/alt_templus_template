function celphoneMask(phone){
	if (phone.replace(/\D/g, "").length === 9) {
		return "00000-0000";
	} else {
		return "0000-00009";
	}
};

function celphonedddMask(phone){
	if (phone.replace(/\D/g, "").length === 11) {
		return "(00) 00000-0000";
	} else {
		return "(00) 0000-00009";
	}
};

function atualiza_campos_crud(){
	$('.datepicker').datepicker({
		todayBtn: "linked",
		keyboardNavigation: false,
		forceParse: false,
		calendarWeeks: true,
		autoclose: true
	});
	
	$("input.mask-telefone-ddd").mask(celphonedddMask, {onKeyPress: function(val, e, field, options) {
      field.mask(celphonedddMask.apply({}, arguments), options);
  }});
  $("input.mask-telefone").mask(celphoneMask, {onKeyPress: function(val, e, field, options) {
    field.mask(celphoneMask.apply({}, arguments), options);
  }});

	$(".timepicker").timepicker({
		minuteStep: 5,
		showInputs: false,
		showMeridian: false,
		disableFocus: true
	});

	$(".chosen").chosen();
	
	$('.i-checks').iCheck({
		checkboxClass: 'icheckbox_square-green',
		radioClass: 'iradio_square-green'
	});
	
	$('.raro_date_range').daterangepicker({
		format: 'DD/MM/YYYY',
		ranges: {
			'Hoje': [moment(), moment()],
			'Ontem': [moment().subtract('days', 1), moment().subtract('days', 1)],
			'Últimos 7 dias': [moment().subtract('days', 6), moment()],
			'Últimos 30 dias': [moment().subtract('days', 29), moment()],
			'Este Mês': [moment().startOf('month'), moment().endOf('month')],
			'Mês Passado': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
		},  
		startDate: moment().subtract('days', 60),
		endDate: moment()         
	},function(start, end) {
		$($(document.getElementById(this.element.context.id)).data('start-target')).val(start.format('YYYY-MM-DD 00:00'))
		$($(document.getElementById(this.element.context.id)).data('end-target')).val(end.format('YYYY-MM-DD 23:59'))
	});
	
	$("[data-provider='summernote']").each(function(){
		$(this).summernote({ });
	});
	
	$('.modal').not(".note-dialog > .modal").appendTo("body");
	
	$('.note-editor .note-dialog .modal').off('hidden.bs.modal')
	$('.note-editor .note-dialog .modal').on('hidden.bs.modal', function () {
		$(".note-dialog").appendTo($(".note-editor"));
	});
	
	$('.crud-new-record').click(function(){
		var select = $(this).siblings().last().find('select')
		var id = select.attr('id')
		var name = select.attr('name')
		new_record(id,name)
		return false;
	});
	
	$(document).off('click', '[data-event$="Dialog"]')
	$(document).on('click', '[data-event$="Dialog"]', function (e) {
		$(".note-editor .note-dialog").appendTo("body");
		$('.modal-backdrop').appendTo("body");
	});
	
	$(document).off("click", ".add_nested_fields")
	$(document).on("click", ".add_nested_fields", function(){
		atualiza_campos_crud();
	});
	
	$(document).off('shown.bs.modal')
	$(document).on('shown.bs.modal', function (e) {
		$('.modal-backdrop').appendTo("body");
	});
};

$(document).ready(function (){
	$("li.menu").on('click', function (){
		$("li.active").removeClass("active");
		var atual = $(this)
		$("ul.collapse.in").each(function(index, e){
			if(!atual.parents().is(e)){
				$(e).collapse('hide');
			}
		});
		$(this).addClass("active");
		
		
		$('.menu > a')
          .not('[data-toggle="dropdown"]')
          .click(function(ev) {
            $('.navbar-collapse.collapse.in').removeClass('in');
          });
	});
	
	$("li.parent-menu").on('click', function (){
		$(this).addClass("active");
	});
});