FROM public.ecr.aws/lambda/ruby:2.7

COPY handler.rb Gemfile ./

ENV GEM_HOME=${LAMBDA_TASK_ROOT}
RUN bundle install

# Command can be overwritten by providing a different command in the template directly.
CMD ["handler.translate"]
