@AppSubscribe = do ->
  init: ->
    @doc = $ document
    @inited ||= do =>
      form_class = '.js--app-subscribe--form'
      btn        = $(form_class).find('.js--app-subscribe--form-btn')

      @doc.on 'ajax:send', form_class, ->
        btn.prop('disabled', true)

      @doc.on 'ajax:complete', form_class, (xhr, data, status) ->
        btn.prop('disabled', false)

      @doc.on 'ajax:success', form_class, (xhr, data, status) ->
        JODY.processor(data)