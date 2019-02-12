import $ from "jquery"
import React from "react"
import PropTypes from "prop-types"
import Typography from "@material-ui/core/Typography"
import Button from "@material-ui/core/Button"
import TextField from "@material-ui/core/TextField"
import blue from "@material-ui/core/colors/blue";
import { MuiThemeProvider, createMuiTheme, withStyles } from "@material-ui/core/styles"

const theme = createMuiTheme({
  palette: {
    primary: blue,
    secondary: {
      main: "#e91e63",
    },
  },
})

const styles = theme => ({
  button: {
    margin: ".5rem"
  }
})

function EmailAlertRegistrationForm(props) {
  const { classes, value, form_id } = props

  var value_txt = value || ""

  const submit_form = () => {
    $("#" + form_id).submit()
  }

  return (
    <MuiThemeProvider theme={theme}>
      <div className="text--container--item">
        <TextField
          autoFocus
          margin="dense"
          id="email"
          name="email"
          label="Email Address"
          type="email"
          variant="outlined"
          defaultValue={value_txt}
          fullWidth
        />
      </div>
      <div className="text--container--item">
        <Button onClick={submit_form} variant="contained" className={classes.button}>
          Register
        </Button>
      </div>
    </MuiThemeProvider>
  )
}

EmailAlertRegistrationForm.propTypes = {
  value: PropTypes.string,
  form_id: PropTypes.string,
  classes: PropTypes.object.isRequired
}

export default withStyles(styles)(EmailAlertRegistrationForm)
