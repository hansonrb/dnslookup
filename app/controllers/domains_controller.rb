

class DomainsController < ApplicationController
  def index
    @domains = Domain.all
  end

  def new
  end

  def create
    incoming_domains = params[:domain_list].strip.split(/\r?\n/)

    incoming_domains.each do |domain|
      new_domain = Domain.create(name: domain)
      new_domain.process_office365
    end
    redirect_to domains_path
  end

  def edit
    get_domain_from_params
  end

  def update
    get_domain_from_params
    @domain.update_attribute(:name, params[:name])
  end

  def process_dns
    get_domain_from_params
    @domain.process_office365
  end

  def destroy
    get_domain_from_params
    @domain.destroy
    redirect_to domains_path
  end

  private
  def get_domain_from_params
    @domain = Domain.find params[:id]
  end
end
