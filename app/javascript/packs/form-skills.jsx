import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import {Typeahead} from 'react-bootstrap-typeahead'

class FormSkill extends Component {

  constructor(props) {
    super(props);

    this.state = {
      competences: props.competences,
      skills: props.devskills,
      skillLevel:1,
      selectedValue: []
    }
  }


  add() {
    const skillName = this.state.selectedValue[0].value;
    const skillValue = this.state.skillLevel;

    const skillObj = { name: skillName, level: skillValue }
    const newSkills = [ ...this.state.skills, skillObj ]
    const updatedList = this.newListCompetences(skillName);

    this.setState({
      skills: newSkills,
      skillLevel:1,
      selectedValue: [],
      competences: updatedList
    })

    this.postSkill(skillObj);
  }


  postSkill = (skill) => {
    console.log(`/api/${this.props.resource}/${this.props.id}/skills`)
    fetch(`/api/${this.props.resource}/${this.props.id}/skills`,{
      method: 'POST',
      body: JSON.stringify(skill),
      headers: new Headers({
        'Content-Type': 'application/json'
      })
    })
    .then(this.handleErrors)
    .then(res => res.json())
    .then(response => {
      console.log(response)
    })
    .catch(error => console.log(error));
  }


  newListCompetences = (value) => {
    return this.state.competences.filter(function( obj ) {
        return obj.value !== value;
    })
  }


  onSelectSkill = (val) => {
    if(!val.length) return;
    this.setState({ selectedValue: val  });
  }

  remove(i) {
    const toRemove = this.state.skills[i];
    const newSkills = [...this.state.skills.slice(0,i), ...this.state.skills.slice(i+1)]
    const updatedList = this.state.competences.concat({ value: toRemove.name })
    this.setState({
      skills: newSkills,
      competences: updatedList
    })
    this.deleteSkill(toRemove.name);
  }

  deleteSkill = (skill) => {
    fetch(`/api/${this.props.resource}/${this.props.id}/skills/${skill}`, {
      method: 'DELETE',
      headers: new Headers({ 'Content-Type': 'application/json' })
    })
    .catch(error => console.error('Error:', error))
    .then(response => {
      console.log(response)
    })
  }

  onChangeLevel = (e) => {
    this.setState({skillLevel: e.target.value});
  }

  render() {
    const { skills, competences, skillLevel, selectedSkill, selectedValue } = this.state;
    const listOfSkills = skills.map((el, i) => (
      <div className="skill-list d-flex justify-content-between" key={i}>
        <div className="skill-icon">
          <i className={`devicon-${el.name}-plain colored`}></i>
          <span className="skill-name">{el.name}</span> - {el.level}
        </div>
        <button className="btn btn-sm btn-outline-warning" onClick={(e) => this.remove(i)}>remove</button>
      </div>
    ))

    return(
      <div>
        {listOfSkills}
        <div className="form-group">
          <Typeahead
            labelKey="value"
            options={competences}
            placeholder="Select a skill..."
            onChange={this.onSelectSkill}
            selected={selectedValue}
            renderMenuItemChildren={(option, props, index) => {
               return (<p><i className={`devicon-${option.value}-plain colored`}></i> {option.value}</p>)
             }}
          />
        </div>
        {selectedValue.length > 0 &&
        <div>
          <p>Please select the level:</p>
          <div className="form-group">
            <input className="form-control-range" type="range" min="1" max="5" value={skillLevel} onChange={this.onChangeLevel} step="1"/>
          </div>
          <button className="btn btn-primary" onClick={(e) => this.add(e)}>add skill</button>
        </div>
        }
      </div>
    )
  }

}


document.addEventListener('DOMContentLoaded', () => {
  const el = document.getElementById('form-skills');
  if (!el) return;

  const competences =  JSON.parse(el.dataset.competences);
  const devSkills =  JSON.parse(el.dataset.devskills);
  const resource =  el.dataset.resource
  const id = el.dataset.id

  ReactDOM.render(
    <FormSkill  competences={competences} devskills={devSkills} id={id} resource={resource} />, document.getElementById('form-skills')
  )
})
