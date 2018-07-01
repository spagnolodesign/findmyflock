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
      selectedValue: [],
      valuesLevels: ["1", "2", "3", "4", "5"],
      error: "",
      rangeLevels: {
        "1": "<h5>Familiarity</h5><p>Needs mentorship</p><p>Generally 0-1 years of professional experience</p>",
        "2": "<h5>Gaining Competency</h5><p>Occasionally needs mentorship</p><p>Generally 1-3 years of professional experience</p>",
        "3": "<h5>Individual Competency</h5><p>No longer needs daily mentorship</p><p>Generally 3-5 years of professional experience</p>",
        "4": "<h5>Strong Competency</h5><p>Could mentor others</p><p>5+ years of professional experience</p>",
        "5": "<h5>Leadership</h5><p>Has lead or managed a team in this subject</p><p>Expert competency</p>"
      }
    }
  }


  add() {
    const skillName = this.state.selectedValue[0].value;
    const skillValue = this.state.skillLevel;
    const skillObj = { name: skillName, level: skillValue }
    const newSkills = [ ...this.state.skills, skillObj ]
    // const updatedList = this.newListCompetences(skillName);

    if (this.props.resource === "developers" && this.state.skills.length >= 30) {
      this.setState({ error: "Max 10 skills allowed!"})
      return;
    }

    if (this.props.resource === "jobs" && this.state.skills.length >= 2) {
      this.setState({ error: "Max 2 skills allowed!"})
      return;
    }

    if (this.state.skills.filter(e => e.name === skillName).length > 0) {
      this.setState({ error: "You already have this skill, please remove it before adding it to the list."})
      return;
    }

    this.setState({
      skills: newSkills,
      skillLevel:1,
      selectedValue: [],
      error: ""
    })
    this.postSkill(skillObj);

  }


  postSkill = (skill) => {
    fetch(`/api/${this.props.resource}/${this.props.id}/skills`,{
      method: 'POST',
      body: JSON.stringify(skill),
      headers: new Headers({
        'Content-Type': 'application/json'
      })
    })
    .then(this.handleErrors)
    .then(res => res.json())
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
    // const updatedList = this.state.competences.concat({ value: toRemove.name })
    this.setState({
      skills: newSkills,
      error: ""
    })
    this.deleteSkill(toRemove.name);
  }

  deleteSkill = (skill) => {
    fetch(`/api/${this.props.resource}/${this.props.id}/skills/${skill}`, {
      method: 'DELETE',
      headers: new Headers({ 'Content-Type': 'application/json' })
    })
    .catch(error => console.error('Error:', error))
  }

  onChangeLevel = (e) => {
    console.log("triggered!", e.target.value)
    this.setState({skillLevel: e.target.value});
  }

  render() {
    const { error, skills, competences, skillLevel, selectedSkill, selectedValue, valuesLevels, rangeLevels} = this.state;

    const listOfSkills = skills.map((el, i) => (
      <div className="skill-form-list d-flex justify-content-between" key={i}>
        <div className="skill-form-icon">
          <i className={`devicon-${el.name}-plain colored`}></i>
          <span className="skill-form-name">{el.name}</span> - {el.level}
        </div>
        <button className="btn btn-sm btn-outline-warning" onClick={(e) => this.remove(i)}>remove</button>
      </div>
    ))

    const rangeValues = valuesLevels.map((el, i) => (
      <div key={i}>
        {el}
      </div>
    ))

    return(
      <div>
        <div className="mt-3 form-group">
          {error.length > 0 &&
            <div className="alert alert-danger" role="alert">
              {error}
            </div>
          }
          <Typeahead
            labelKey="value"
            options={competences}
            placeholder="Select a skill..."
            paginate={false}
            onChange={this.onSelectSkill}
            selected={selectedValue}
            className="skills-select"
            renderMenuItemChildren={(option, props, index) => {
               return (<p><i className={`devicon-${option.value}-plain colored`}></i> {option.value}</p>)
             }}
          />
        </div>
        {selectedValue.length > 0 &&
        <div>
          <div className="form-group p-3 my-2 bg-white rounded text-center">
            <p className="mb-2">Please select your {selectedValue[0].value} level:</p>
            <input className="form-control-range" type="range" min="1" max="5" value={skillLevel} onInput={this.onChangeLevel} onChange={this.onChangeLevel} />
            <div className="d-flex justify-content-between">
              {rangeValues}
            </div>
            <div className="my-2" dangerouslySetInnerHTML={{ __html: rangeLevels[skillLevel] }} />
            <button className="btn btn btn-outline-primary" onClick={(e) => this.add(e)}>Add to your skills</button>
          </div>
        </div>
        }
        {listOfSkills}
      </div>
    )
  }

}


const initFormSkill = document.addEventListener('DOMContentLoaded', () => {
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

export {initFormSkill};
