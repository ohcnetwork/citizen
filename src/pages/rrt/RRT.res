let str = React.string

@react.component
let make = () =>
  <div className="mx-auto">
    <div className="mx-auto max-w-5xl">
      <h1 className="text-3xl md:text-5xl mt-4 font-black text-center"> {str("RRT Directory")} </h1>
    </div>
  </div>
