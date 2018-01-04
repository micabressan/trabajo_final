<div tabindex="1" (focusout)="expand(false)" (focus)="expand(true)" >
					<button [ngClass]="{'dropdown-button':expandedFilter}" id="dropdownCompanyRoles" data-toggle="dropdown">
						Filter projects
					</button>
					<div [ngClass]="{'dropdown-selection':expandedFilter}" aria-labelledby="dropdownCompanyRoles">
						<div>
							<div style="display: flex; justify-content: space-between;">
								<button class="btn btn-success" (click)="applyFilters()">Apply</button>
								<button class="btn btn-primary" (click)="discardFilters()">Discard</button>
							</div>
						</div>
					</div>
				</div>