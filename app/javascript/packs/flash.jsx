import React, {Component} from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

export class Flash extends Component {
 constructor(props) {
    super();
    this.state = {
      show:true,
      type: (!props.alert) ? "alert-success" : "alert-danger"
    }
 }

 componentDidMount(){
   setTimeout(function() { this.setState({show: false}); }.bind(this), 5000);
 }

 render(){
   const {show, type} = this.state
   if (!show){
    return (<div></div>);
   }
   return(
     <div className={`alert alert-primary ${type} mt-3`} role="alert">
        <span>{this.props.alert || this.props.notice}</span>
     </div>
   )
 }
}

const initFlashAlert =document.addEventListener('DOMContentLoaded', () => {
  const el = document.getElementById("alert-component");

  if (el != null) {
    const alert_txt = el.getAttribute('data-alert');
    const notice_txt = el.getAttribute('data-notice');
    ReactDOM.render(
      <Flash alert={alert_txt} notice={notice_txt} />, el,
    )
  }
})

export { initFlashAlert }
