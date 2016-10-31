module MessageHelper
  def unavailable_endpoint
    'The end point #{params[:url]} is not available.'
  end

  def invalid_session
    'Not Authorized/Session Expired. Please Login'
  end

  def anauthorized_access
    'Not Authorized'
  end

  def invalid_credentials
    'Invalid email/password'
  end

  def logged_out
    'You have been logged out'
  end

  def resource_destroyed
    'The resource has been deleted'
  end
end
