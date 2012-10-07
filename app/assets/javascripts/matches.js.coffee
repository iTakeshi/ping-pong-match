# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    attend = (member_li)->
        $(member_li).addClass('btn-success')
        $(member_li).addClass('active')

    absent = (member_li)->
        $(member_li).removeClass('btn-success')
        $(member_li).removeClass('active')

    if !($.cookie('attendance'))
        $.cookie('attendance', ' ')
    attendance = $.cookie('attendance').split(',')
    $.each attendance, ->
        attend('li[data-member-id="' + @ + '"]')

    $('.attendance-member').click (e)->
        member_id = $(@).attr('data-member-id')
        if $(@).hasClass('active')
            attendance.splice($.inArray(member_id, attendance), 1)
            $.cookie('attendance', attendance.join())
            absent(@)
        else
            attendance.push(member_id)
            $.cookie('attendance', attendance.join())
            attend(@)
