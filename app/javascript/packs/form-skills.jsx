import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import {Typeahead} from 'react-bootstrap-typeahead'

// GET SKILLS
// /api/developers/:developer_id/skills

// POST SKILLS
// /api/developers/:developer_id/skills

// DELETE SKILLS
// /api/developers/:developer_id/skills/:id

class FormSkill extends Component {

  constructor(props) {
    super(props);

    this.state = {
      competences: props.competences,
      skills: props.devskills,
      skillLevel:1
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
      selectedValue: [""],
      competences: updatedList
    })
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
        <Typeahead
          labelKey="value"
          options={competences}
          placeholder="Choose a skill..."
          onChange={this.onSelectSkill}
          selected={selectedValue}
        />
        <input type="range" min="1" max="5" value={skillLevel} onChange={this.onChangeLevel} step="1"/>
        <button className="btn btn-primary" onClick={(e) => this.add(e)}>add skill</button>
      </div>
    )
  }


}



document.addEventListener('DOMContentLoaded', () => {
  const el = document.getElementById('form-skills');
  if (!el) return;

  const competences =  JSON.parse(el.dataset.competences);
  const devSkills =  JSON.parse(el.dataset.devskills);

  ReactDOM.render(
    <FormSkill  competences={competences} devskills={devSkills} />, document.getElementById('form-skills')
  )
})
