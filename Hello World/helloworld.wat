(module

  ;; Expect the import object env from the embedding environment
  ;; and within that object, expect the function `print_string`
  (import "env" "print_string" (func $print_string( param i32 )))

  ;; Import a memory buffer from the object env and call it `buffer`
  ;; Buffer is a single page of linear memory (64KB)
  (import "env" "buffer" (memory 1))

  ;; A number imported from JS.
  ;; Its value indicates the starting memory location
  (global $start_string (import "env" "start_string") i32)
  
  ;; A constant to represent the length of the string 
  ;; Hello World! -> 12 (unicode) chars
  (global $string_len i32 (i32.const 12))
  
  ;; Pass the location in memory where the module will write data
  ;; Data is stored in the $start_string global variable
  ;; The second parameter is the data string
  (data (global.get  $start_string) "hello world!")
  
  ;; Define the helloworld function and add it to the module
  ;; Call the imported `$print_string` function
  (func (export "helloworld")
    (call $print_string (global.get $string_len))
  )
)