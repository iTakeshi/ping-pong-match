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
        $.cookie('attendance', '')
    attendance = $.cookie('attendance').split(',')
    $.each attendance, ->
        attend('li[data-member-id="' + @ + '"]')

    if !($.cookie('match_type'))
        $.cookie('match_type', '')
    if !($.cookie('match_gender'))
        $.cookie('match_gender', '')
    if !($.cookie('match_rank'))
        $.cookie('match_rank', '')
    attend('button[data-match-type="' + $.cookie('match_type') + '"]')
    attend('button[data-match-gender="' + $.cookie('match_gender') + '"]')
    attend('button[data-match-rank="' + $.cookie('match_rank') + '"]')

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

    $('#match-config button').click (e) ->
        $(@).closest('dd').children('button').removeClass('btn-success')
        $(@).addClass('btn-success')

    $('#match-type button').click (e) ->
        $.cookie('match_type', $(@).attr('data-match-type'))
    $('#match-gender button').click (e) ->
        $.cookie('match_gender', $(@).attr('data-match-gender'))
    $('#match-rank button').click (e) ->
        $.cookie('match_rank', $(@).attr('data-match-rank'))

    $('#generate-match').on 'ajax:complete', (response, ajax, status) ->
        data = $.parseJSON(ajax.responseText)
        table = $('#match-table')
        table.empty()
        $.each data.matches, (key, value) ->
            table.append('<h4>' + key + '</h4>')
            table.append('<ul class="match-list"></ul>')
            $.each value, ->
                $('ul:last').append('<li>' + @[0] + ' vs. ' + @[1] + '</li>')
        table.append('<h4>抽選漏れ</h4>' + data.rest)
