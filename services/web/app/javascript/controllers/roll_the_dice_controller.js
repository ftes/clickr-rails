import { Controller } from 'stimulus'
import shuffle from 'lodash/shuffle'

export default class extends Controller {
  static targets = ['student', 'studentThatResponded']

  get durationMs() {
    return Number.parseInt(this.data.get('duration-ms')) || 3000
  }

  connect() {
    const button = document.getElementById('rollTheDiceButton')
    if (button) {
      button.addEventListener('click', this.rollTheDice.bind(this))
    }
  }

  async rollTheDice() {
    const intermediateClass = 'has-background-warning'
    const finalClass = 'has-background-danger'
    const students = this.studentThatRespondedTargets.length > 0 ? this.studentThatRespondedTargets : this.studentTargets;
    const shuffledStudents = shuffle(students)
    const durationPerStudent = this.durationMs / shuffledStudents.length

    this.studentTargets.forEach(s => {
      s.classList.remove(intermediateClass, finalClass)
    })

    for (const [i, student] of shuffledStudents.entries()) {
      const isLast = i == shuffledStudents.length - 1
      student.classList.add(isLast ? finalClass : intermediateClass)
      await sleep(durationPerStudent)
      student.classList.remove(intermediateClass)
    }
  }
}

const sleep = ms => new Promise(resolve => setTimeout(resolve, ms))
