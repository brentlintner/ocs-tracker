import React from "react"
import PropTypes from "prop-types"
import $ from "jquery"
import deburr from "lodash/deburr"
import map from "lodash/map"
import includes from "lodash/includes"
import lowerCase from "lodash/lowerCase"
import findIndex from "lodash/findIndex"
import Downshift from "downshift"
import { withStyles } from "@material-ui/core/styles"
import TextField from "@material-ui/core/TextField"
import Popper from "@material-ui/core/Popper"
import Paper from "@material-ui/core/Paper"
import MenuItem from "@material-ui/core/MenuItem"
import Chip from "@material-ui/core/Chip"
import SearchIcon from "@material-ui/icons/Search"

function renderInput(inputProps) {
  const { InputProps, classes, ref, ...other } = inputProps

  return (
    <TextField
      InputProps={{
        inputRef: ref,
        classes: {
          root: classes.inputRoot,
          input: classes.inputInput,
        },
        ...InputProps,
      }}
      {...other}
    />
  )
}

function renderSuggestion({ suggestion, index, itemProps, highlightedIndex, selectedItem }) {
  const isHighlighted = highlightedIndex === index
  const isSelected = (selectedItem || "").indexOf(suggestion.label) > -1

  return (
    <MenuItem
      {...itemProps}
      key={suggestion.label}
      selected={isHighlighted}
      component="div"
      style={{ fontWeight: 400 }}
    >
      {suggestion.label}
    </MenuItem>
  )
}

renderSuggestion.propTypes = {
  highlightedIndex: PropTypes.number,
  index: PropTypes.number,
  itemProps: PropTypes.object,
  selectedItem: PropTypes.string,
  suggestion: PropTypes.shape({ label: PropTypes.string }).isRequired,
}

function getSuggestions(value, suggestions) {
  const inputValue = lowerCase(deburr(value.trim()))
  let count = 0

  return inputValue.length === 0
    ? []
    : suggestions.filter(suggestion => {
        const keep =
          count < 5 && includes(lowerCase(suggestion.label), inputValue)

        if (keep) count += 1

        return keep
      })
}

const styles = theme => ({
  root: {
    flexGrow: 1,
    height: 250,
  },
  container: {
    position: "relative"
  },
  paper: {
    position: "absolute",
    zIndex: 1,
    marginTop: ".5rem",
    left: "-3.25rem",
    width: window.innerWidth,
    right: 0
  },
  inputRoot: {
    flexWrap: "wrap",
    paddingLeft: ".5rem"
  },
  inputInput: {
    fontSize: "1.25rem",
    color: "#FFFFFF"
  }
})

const enableSearch = (event) => {
  $(".app--title").hide()
  $(".app--search").css({
    flex: 1,
    width: "auto",
    visibility: "visible"
  })
  $(".app--search input").css({
    width: "auto"
  })
  .focus()
}

const disableSearch = (event) => {
  $(".app--search").css({
    flex: "none",
    width: "3rem",
    visibility: "hidden"
  })
  $(".app--search input").css({
    width: "3rem"
  })
  $(".app--title").show()
}

const handleEnter = (suggestions) => (event) => {
  if (event.key == "Enter") {
    var suggestion = suggestions[findIndex(
      suggestions, { label: event.target.value }) ]
    window.Turbolinks.visit(suggestion.url)
  }
}

const handleClick = (suggestion) => (event) => {
  window.Turbolinks.visit(suggestion.url)
}

function SearchBar(props) {
  const { classes, suggestions } = props

  return (
    <div>
      <Downshift className={classes.root} id="downshift-simple">
        {({
          getInputProps,
          getItemProps,
          getMenuProps,
          highlightedIndex,
          inputValue,
          isOpen,
          selectedItem,
        }) => (
          <div className={"app--search " + classes.container}>
            {renderInput({
              fullWidth: true,
              classes,
              inputProps: {
                onBlur: disableSearch,
                onKeyUp: handleEnter(suggestions)
              },
              InputProps: getInputProps({
                placeholder: "",
              }),
            })}
            <div {...getMenuProps()}>
              {isOpen ? (
                <Paper className={classes.paper} square>
                  {getSuggestions(inputValue, suggestions).map((suggestion, index) =>
                    renderSuggestion({
                      suggestion,
                      index,
                      itemProps: getItemProps({
                        onClick: handleClick(suggestion),
                        item: suggestion.label
                      }),
                      highlightedIndex,
                      selectedItem,
                    }),
                  )}
                </Paper>
              ) : null}
            </div>
          </div>
        )}
      </Downshift>
      <SearchIcon onClick={enableSearch} className="app--search--icon" />
    </div>
  )
}

SearchBar.propTypes = {
  classes: PropTypes.object.isRequired,
  suggestions: PropTypes.array
}

export default withStyles(styles)(SearchBar)
