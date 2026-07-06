import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ProjectAdd } from './project-add';

describe('ProjectAdd', () => {
  let component: ProjectAdd;
  let fixture: ComponentFixture<ProjectAdd>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ProjectAdd],
    }).compileComponents();

    fixture = TestBed.createComponent(ProjectAdd);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
