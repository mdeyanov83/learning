class Person {
    talk() {
        return 'Talking';
    }
}

class SuperHuman extends Person {
    fly() {
        return 'Flying';
    }
}

const me = new Person();
const you = new SuperHuman();

console.log(me.talk());
console.log(you.talk());

console.log(you.__proto__.__proto__);

console.log(Object);
